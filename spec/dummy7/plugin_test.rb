# frozen_string_literal: true

require 'test_helper'

module Dummy
  class PluginTest < ActiveSupport::TestCase
    test 'it has a version number' do
      assert Dummy::Plugin::VERSION
    end
  end
end
