require 'test_helper'

module Falling
  class NodeTest < Minitest::Test
    def test_identifiers_are_unique
      a = Node.new
      b = Node.new
      refute_equal a.identifier, b.identifier
    end

    def test_identifiers_do_not_change
      a = Node.new
      assert_equal a.identifier, a.identifier
    end
  end
end
