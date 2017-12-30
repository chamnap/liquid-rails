require 'spec_helper'

class TextFilterKlass
  include Liquid::Rails::TextFilter
end

module Liquid
  module Rails
    describe TextFilter do
      subject { TextFilterKlass.new }

      it { should delegate(:highlight).to(:__h__) }
      it { should delegate(:excerpt).to(:__h__) }
      it { should delegate(:pluralize).to(:__h__) }
      it { should delegate(:word_wrap).to(:__h__) }
      it { should delegate(:simple_format).to(:__h__) }
    end
  end
end
