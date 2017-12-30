require 'spec_helper'

class SanitizeFilterKlass
  include Liquid::Rails::SanitizeFilter
end

module Liquid
  module Rails
    describe SanitizeFilter do
      subject { SanitizeFilterKlass.new }

      it { should delegate(:strip_tags).to(:__h__) }
      it { should delegate(:strip_links).to(:__h__) }
    end
  end
end
