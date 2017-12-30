require 'spec_helper'

class AssetUrlFilterKlass
  include Liquid::Rails::AssetUrlFilter
end

module Liquid
  module Rails
    describe AssetUrlFilter do
      subject { AssetUrlFilterKlass.new }

      it { should delegate(:asset_path).to(:__h__) }
      it { should delegate(:asset_url).to(:__h__) }

      it { should delegate(:audio_path).to(:__h__) }
      it { should delegate(:audio_url).to(:__h__) }

      it { should delegate(:font_path).to(:__h__) }
      it { should delegate(:font_url).to(:__h__) }

      it { should delegate(:image_path).to(:__h__) }
      it { should delegate(:image_url).to(:__h__) }

      it { should delegate(:javascript_path).to(:__h__) }
      it { should delegate(:javascript_url).to(:__h__) }

      it { should delegate(:stylesheet_path).to(:__h__) }
      it { should delegate(:stylesheet_url).to(:__h__) }

      it { should delegate(:video_path).to(:__h__) }
      it { should delegate(:video_url).to(:__h__) }
    end
  end
end
