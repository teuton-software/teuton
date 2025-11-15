require "test/unit"
require_relative "../../lib/teuton/utils/settings"

class SettingsTest < Test::Unit::TestCase
  def test_values
    assert_equal ".", Settings.letter[:good]
    assert_equal "F", Settings.letter[:fail]
    assert_equal "?", Settings.letter[:error]
    assert_equal " ", Settings.letter[:none]
  end
end
