module Liquid
  module Rails
    class Drop < ::Liquid::Drop

      class << self
        attr_accessor :_attributes
        attr_accessor :_associations
      end

      def self.inherited(base)
        base._attributes   = []
        base._associations = {}
      end

      def self.attributes(*attrs)
        @_attributes.concat attrs

        attrs.each do |attr|
          next if method_defined?(attr)

          define_method(attr) do
            object.send(attr)
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

      def self.dropify(resource, options={})
        drop_class  = drop_class_for(resource, options[:class_name])
        drop_class.new(resource, options.except(:class_name))
      end

      def self.drop_class_for(resource, class_name=nil)
        if class_name.present?
          class_name.safe_constantize
        elsif resource.respond_to?(:to_ary)
          collection_drop_class
        elsif self.name != 'Liquid::Rails::Drop'
          self
        else
          resource.drop_class
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
            value = instance_variable_get("@_#{attr}")
            return value if value

            association = object.send(attr)
            value       = association.nil? ? nil : Liquid::Rails::Drop.dropify(association, options)
            instance_variable_set("@_#{attr}", value)
          end

          self._associations[attr] = { type: type, options: options }
        end
      end

      def initialize(object, options={})
        @object = object
      end

      def attributes(options = {})
        @attributes ||= self.class._attributes.dup.each_with_object({}) do |name, hash|
          hash[name.to_s] = send(name)
        end
      end

      def before_method(method)
        attributes[method.to_s]
      end

      def inspect
        "#<#{self.class.name} @object: #{object.inspect} @attributes: #{attributes.inspect}>"
      end

      protected

        attr_reader :object
    end
  end
end