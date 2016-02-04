require 'spec_helper'

class TextFilterKlass
  include Liquid::Rails::TextFilter
end

module Liquid
  module Rails
    describe TextFilter do
      subject { TextFilterKlass.new }

      it { should delegate(:highlight).to(:h) }
      it { should delegate(:excerpt).to(:h) }
      it { should delegate(:pluralize).to(:h) }
      it { should delegate(:word_wrap).to(:h) }
      it { should delegate(:simple_format).to(:h) }
      it { should delegate(:concat).to(:h) }
    end
  end
end