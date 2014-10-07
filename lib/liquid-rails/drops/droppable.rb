module Liquid
  module Rails
    module Droppable
      extend ActiveSupport::Concern

      def to_liquid
        drop_class.new(self)
      end
      alias_method :dropify, :to_liquid

      def drop_class
        self.class.drop_class
      end

      module ClassMethods
        def drop_class
          "#{self.name}Drop".safe_constantize
        end
      end
    end
  end
end