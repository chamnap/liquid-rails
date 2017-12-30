require 'spec_helper'

class DateFilterKlass
  include Liquid::Rails::DateFilter
end

module Liquid
  module Rails
    describe DateFilter do
      subject { DateFilterKlass.new }

      it { should delegate(:distance_of_time_in_words).to(:__h__) }
      it { should delegate(:time_ago_in_words).to(:__h__) }
    end
  end
end
