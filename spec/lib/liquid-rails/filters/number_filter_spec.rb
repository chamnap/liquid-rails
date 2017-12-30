require 'spec_helper'

class NumberFilterKlass
  include Liquid::Rails::NumberFilter
end

module Liquid
  module Rails
    describe NumberFilter do
      subject { NumberFilterKlass.new }

      it { should delegate(:number_to_phone).to(:__h__) }
      it { should delegate(:number_to_currency).to(:__h__) }
      it { should delegate(:number_to_percentage).to(:__h__) }
      it { should delegate(:number_with_delimiter).to(:__h__) }
      it { should delegate(:number_with_precision).to(:__h__) }
      it { should delegate(:number_to_human_size).to(:__h__) }
      it { should delegate(:number_to_human).to(:__h__) }
    end
  end
end
