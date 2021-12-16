# frozen_string_literal: true

require 'spec_helper'

class SanitizeFilterKlass
  include Liquid::Rails::SanitizeFilter
end

module Liquid
  module Rails
    describe SanitizeFilter do
      subject { SanitizeFilterKlass.new }

      it { is_expected.to delegate(:strip_tags).to(:__h__) }
      it { is_expected.to delegate(:strip_links).to(:__h__) }
    end
  end
end
