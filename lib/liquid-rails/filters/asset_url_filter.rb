module Liquid
  module Rails
    module AssetUrlFilter
      delegate \
                :asset_path,
                :asset_url,

                :audio_path,
                :audio_url,

                :font_path,
                :font_url,

                :image_path,
                :image_url,

                :javascript_path,
                :javascript_url,

                :stylesheet_path,
                :stylesheet_url,

                :video_path,
                :video_url,

                to: :__h__

      private

        def __h__
          @context.registers[:view]
        end
    end
  end
end

Liquid::Template.register_filter(Liquid::Rails::AssetUrlFilter)
