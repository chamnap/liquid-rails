module Liquid
  module Rails
    class CollectionDrop < ::Liquid::Drop
      include Enumerable

      def self.scope(name)
        define_method(name) do
          raise ArgumentError, "#{objects.klass.name} doesn't define scope: #{name}" unless objects.respond_to?(name)

          Liquid::Rails::Drop.dropify(objects.send(name))
        end
      end

      delegate :each, to: :@objects

      array_methods = Array.instance_methods - Object.instance_methods
      delegate *array_methods, to: :dropped_collection

      def initialize(objects, options={})
        @objects    = objects
      end

      def dropped_collection
        @dropped_collection ||= @objects.map { |item| drop_item(item) }
      end

      def kind_of?(klass)
        dropped_collection.kind_of?(klass) || super
      end
      alias_method :is_a?, :kind_of?

      protected

        attr_reader :objects

        def drop_item(item)
          liquid_drop_class = Liquid::Rails::Drop.drop_for(item)
          liquid_drop_class.new(item)
        end
    end
  end
end