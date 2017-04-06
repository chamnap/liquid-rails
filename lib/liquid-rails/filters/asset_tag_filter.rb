module Liquid
  module Rails
    module AssetTagFilter
      delegate \
                :audio_tag,
                :auto_discovery_link_tag,
                :favicon_link_tag,
                :image_alt,
                :image_tag,
                :javascript_include_tag,
                :stylesheet_link_tag,
                :video_tag,

                to: :h

      def h
        @h ||= @context.registers[:view]
      end
    end
  end
end

Liquid::Template.register_filter(Liquid::Rails::AssetTagFilter)