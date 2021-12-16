# frozen_string_literal: true

require 'spec_helper'

class AssetUrlFilterKlass
  include Liquid::Rails::AssetUrlFilter
end

module Liquid
  module Rails
    describe AssetUrlFilter do
      subject { AssetUrlFilterKlass.new }

      it { is_expected.to delegate(:asset_path).to(:__h__) }
      it { is_expected.to delegate(:asset_url).to(:__h__) }

      it { is_expected.to delegate(:audio_path).to(:__h__) }
      it { is_expected.to delegate(:audio_url).to(:__h__) }

      it { is_expected.to delegate(:font_path).to(:__h__) }
      it { is_expected.to delegate(:font_url).to(:__h__) }

      it { is_expected.to delegate(:image_path).to(:__h__) }
      it { is_expected.to delegate(:image_url).to(:__h__) }

      it { is_expected.to delegate(:javascript_path).to(:__h__) }
      it { is_expected.to delegate(:javascript_url).to(:__h__) }

      it { is_expected.to delegate(:stylesheet_path).to(:__h__) }
      it { is_expected.to delegate(:stylesheet_url).to(:__h__) }

      it { is_expected.to delegate(:video_path).to(:__h__) }
      it { is_expected.to delegate(:video_url).to(:__h__) }
    end
  end
end
