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
        html << %(<span class="prev"><a href="#{paginate['previous']['url']}" rel="prev">#{paginate['previous']['title']}</a></span>) if paginate['previous']

        for part in paginate['parts']
          if part['is_link']
            html << %(<span class="page">#{link_to(part['title'], part['url'])}</span>)
          elsif part['title'].to_i == paginate['current_page'].to_i
            html << %(<span class="page current">#{part['title']}</span>)
          else
            html << %(<span class="deco">#{part['title']}</span>)
          end
        end

        html << %(<span class="next"><a href="#{paginate['next']['url']}" rel="next">#{paginate['next']['title']}</a></span>) if paginate['next']
        html.join(' ')
      end

      # Bootstrap pagination filter
      #
      # @param [ paginate ]
      # @param [ size ]: .pagination-lg, .pagination-sm

      def bootstrap_pagination(paginate, size='')
        html = []
        html << %{<nav><ul class="pagination #{size}">}

        if paginate['previous']
          html << %(<li><a href="#{paginate['previous']['url']}" aria-label="Previous"><span aria-hidden="true">#{paginate['previous']['title']}</span></a></li>)
        else
          html << %(<li class="disabled"><a href="#" aria-label="Previous"><span aria-hidden="true">&laquo; Previous</span></a></li>)
        end

        for part in paginate['parts']
          if part['is_link']
            html << %(<li><a href="#{part['url']}">#{part['title']}</a></li>)
          elsif part['title'].to_i == paginate['current_page'].to_i
            html << %(<li class="active"><a href="#">#{part['title']}</a></li>)
          else
            html << %(<li><a href="#">#{part['title']}</a></li>)
          end
        end

        if paginate['next']
          html << %(<li><a href="#{paginate['next']['url']}" aria-label="Next"><span aria-hidden="true">#{paginate['next']['title']}</span></a></li>)
        else
          html << %(<li class="disabled"><a href="#" aria-label="Next"><span aria-hidden="true">Next &raquo;</span></a></li>)
        end

        html << '</nav></ul>'
        html.join(' ')
      end
    end
  end
end

Liquid::Template.register_filter(Liquid::Rails::MiscFilter)