module Liquid
  module Rails
    class Drop < ::Liquid::Drop

      class << self
        attr_accessor :_attributes
        attr_accessor :_associations
      end

      def self.inherited(base)
        base._attributes   = [:id]
        base._associations = {}
      end

      def self.attributes(*attrs)
        @_attributes.concat attrs

        attrs.each do |attr|
          next if method_defined?(attr)

          define_method(attr) do
            @object.read_attribute_for_serialization(attr)
          end
        end
      end

      def self.collection_drop_class
        name = collection_drop_name
        name.constantize
      rescue NameError => error
        raise if name && !error.missing_name?(name)
        Liquid::Rails::CollectionDrop
      end

      def self.collection_drop_name
        plural = object_class_name.pluralize
        raise NameError if plural == object_class_name
        "#{plural}Drop"
      end

      def self.object_class_name
        raise NameError if name.nil? || name.demodulize !~ /.+Drop$/
        name.chomp('Drop')
      end

      def self.dropify(resource)
        drop_class  = drop_for(resource)
        drop_class.new(resource)
      end

      def self.drop_for(resource)
        if resource.respond_to?(:to_ary)
          collection_drop_class
        else
          "#{resource.class.name}Drop".safe_constantize
        end
      end

      def self.belongs_to(*attrs)
        associate(:belongs_to, attrs)
      end

      def self.has_many(*attrs)
        associate(:has_many, attrs)
      end

      def self.associate(type, attrs)
        options = attrs.extract_options!
        self._associations = _associations.dup

        attrs.each do |attr|
          next if method_defined?(attr)

          define_method attr do
            association = @object.send(attr)
            self.class.dropify(association)
          end

          self._associations[attr] = { type: type, options: options }
        end
      end

      def initialize(object)
        @object = object
      end

      def id
        if @object.id.kind_of?(Integer) || @object.id.kind_of?(String)
          @object.id
        else
          @object.id.to_s
        end
      end

      def attributes(options = {})
        @attributes ||= self.class._attributes.dup.each_with_object({}) do |name, hash|
          hash[name.to_s] = send(name)
        end
      end

      def before_method(method)
        attributes[method.to_s]
      end
    end
  end
end