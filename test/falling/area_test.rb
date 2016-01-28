require 'test_helper'

module Falling
  class AreaTest < Minitest::Test
    def test_dimensions
      area = Area.new(width: 10, height: 20)
      assert_equal 10, area.width
      assert_equal 20, area.height
    end
  end
end
