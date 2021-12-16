# frozen_string_literal: true

require 'spec_helper'

class TextFilterKlass
  include Liquid::Rails::TextFilter
end

module Liquid
  module Rails
    describe TextFilter do
      subject { TextFilterKlass.new }

      it { is_expected.to delegate(:highlight).to(:__h__) }
      it { is_expected.to delegate(:excerpt).to(:__h__) }
      it { is_expected.to delegate(:pluralize).to(:__h__) }
      it { is_expected.to delegate(:word_wrap).to(:__h__) }
      it { is_expected.to delegate(:simple_format).to(:__h__) }
    end
  end
end
