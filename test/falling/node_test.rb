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

    def test_reference
      cat_class = Class.new(Node) { reference :mother }
      mom = cat_class.new
      cat = cat_class.new
      assert_nil mom.mother
      assert_nil cat.mother
      cat.mother = mom
      assert_equal mom, cat.mother
    end
  end
end
