require "test_helper"

class Dummy::PluginTest < ActiveSupport::TestCase
  test "it has a version number" do
    assert Dummy::Plugin::VERSION
  end
end
