module Liquid
  module Rails
    module AssetUrlFilter
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
        @h ||= ActionController::Base.helpers
      end
    end
  end
end