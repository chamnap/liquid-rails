require 'spec_helper'

class AssetUrlFilterKlass
  include Liquid::Rails::AssetUrlFilter
end

module Liquid
  module Rails
    describe AssetUrlFilter do
      subject { AssetUrlFilterKlass.new }

      it { should delegate(:asset_path).to(:view_context) }
      it { should delegate(:asset_url).to(:view_context) }

      it { should delegate(:audio_path).to(:view_context) }
      it { should delegate(:audio_url).to(:view_context) }

      it { should delegate(:font_path).to(:view_context) }
      it { should delegate(:font_url).to(:view_context) }

      it { should delegate(:image_path).to(:view_context) }
      it { should delegate(:image_url).to(:view_context) }

      it { should delegate(:javascript_path).to(:view_context) }
      it { should delegate(:javascript_url).to(:view_context) }

      it { should delegate(:stylesheet_path).to(:view_context) }
      it { should delegate(:stylesheet_url).to(:view_context) }

      it { should delegate(:video_path).to(:view_context) }
      it { should delegate(:video_url).to(:view_context) }
    end
  end
end
