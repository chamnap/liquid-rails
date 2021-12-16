# frozen_string_literal: true

require 'spec_helper'

class AssetTagFilterKlass
  include Liquid::Rails::AssetTagFilter
end

module Liquid
  module Rails
    describe AssetTagFilter do
      subject { AssetTagFilterKlass.new }

      it { is_expected.to delegate(:audio_tag).to(:__h__) }
      it { is_expected.to delegate(:auto_discovery_link_tag).to(:__h__) }
      it { is_expected.to delegate(:favicon_link_tag).to(:__h__) }
      it { is_expected.to delegate(:image_alt).to(:__h__) }
      it { is_expected.to delegate(:image_tag).to(:__h__) }
      it { is_expected.to delegate(:javascript_include_tag).to(:__h__) }
      it { is_expected.to delegate(:stylesheet_link_tag).to(:__h__) }
      it { is_expected.to delegate(:video_tag).to(:__h__) }
    end
  end
end
