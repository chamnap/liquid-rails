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
            object.send(attr) if object.respond_to?(attr, true)
          end
        end
      end

      # By default, `Product` maps to `ProductDrop`.
      #             Array of products maps to `Liquid::Rails::CollectionDrop`.
      def self.drop_class_for(resource)
        if resource.respond_to?(:to_ary)
          Liquid::Rails::CollectionDrop
        else
          if self == Liquid::Rails::Drop
            resource.drop_class || Liquid::Rails::Drop
          else
            self
          end
        end
      end

      # Create a drop instance when it cannot be inferred.
      def self.dropify(resource, options={})
        drop_class = if options[:class_name]
          options[:class_name].constantize
        else
          drop_class_for(resource)
        end

        drop_class.new(resource, options.except(:class_name))
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
            return nil if association.nil?

            drop_instance = Liquid::Rails::Drop.dropify(association, options)
            instance_variable_set("@_#{attr}", drop_instance)
          end

          self._associations[attr] = { type: type, options: options }
        end
      end

      # Wraps an object in a new instance of the drop.
      def initialize(object, options={})
        @object = object
      end

      def attributes
        @attributes ||= self.class._attributes.dup.each_with_object({}) do |name, hash|
          hash[name.to_s] = send(name)
        end
      end

      def as_json(options={})
        attributes.as_json(options)
      end

      def to_json(options={})
        as_json.to_json(options)
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