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

      def default_pagination(paginate)
        html = []
        html << %(<span class="prev">#{link_to(paginate['previous']['title'], paginate['previous']['url'])}</span>) if paginate['previous']

        for part in paginate['parts']

          if part['is_link']
            html << %(<span class="page">#{link_to(part['title'], part['url'])}</span>)
          elsif part['title'].to_i == paginate['current_page'].to_i
            html << %(<span class="page current">#{part['title']}</span>)
          else
            html << %(<span class="deco">#{part['title']}</span>)
          end

        end

        html << %(<span class="next">#{link_to(paginate['next']['title'], paginate['next']['url'])}</span>) if paginate['next']
        html.join(' ')
      end
    end
  end
end

Liquid::Template.register_filter(Liquid::Rails::MiscFilter)