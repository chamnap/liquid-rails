require 'spec_helper'

class AssetTagFilterKlass
  include Liquid::Rails::AssetTagFilter
end

module Liquid
  module Rails
    describe AssetTagFilter do
      subject { AssetTagFilterKlass.new }

      it { should delegate(:audio_tag).to(:h) }
      it { should delegate(:auto_discovery_link_tag).to(:h) }
      it { should delegate(:favicon_link_tag).to(:h) }
      it { should delegate(:image_alt).to(:h) }
      it { should delegate(:image_tag).to(:h) }
      it { should delegate(:javascript_include_tag).to(:h) }
      it { should delegate(:stylesheet_link_tag).to(:h) }
      it { should delegate(:video_tag).to(:h) }
    end
  end
end