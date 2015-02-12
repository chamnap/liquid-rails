require 'json'

module Liquid
  module Rails
    module MiscFilter
      # Get the nth element of the passed in array
      def index(array, position)
        array.at(position) if array.respond_to?(:at)
      end

      def random(input)
        rand(input.to_i)
      end

      def jsonify(object)
        JSON.dump(object)
      end

      # If condition is true, the class_name is returned. Otherwise, it returns nil.
      # class_name: css class name
      # condition: boolean
      def toggle_class_name(class_name, condition)
        condition ? class_name : nil
      end
    end
  end
end

Liquid::Template.register_filter(Liquid::Rails::MiscFilter)