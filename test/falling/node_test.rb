require 'test_helper'

module Falling
  class NodeTest < Minitest::Test
    def setup
      Node.universe = mock_universe
    end

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

    def test_destroyed_node_references_are_nil
      cat_class = Class.new(Node) { reference :mother }
      mom = cat_class.new
      cat = cat_class.new
      cat.mother = mom
      mom.destroy!
      assert_nil cat.mother
    end

    private

    def mock_universe
      Object.new.tap do |universe|
        nodes = {}

        universe.define_singleton_method(:fetch_node) do |identifier|
          nodes[identifier]
        end

        universe.define_singleton_method(:add_node) do |node|
          nodes[node.identifier] = node
        end

        universe.define_singleton_method(:remove_node) do |node|
          nodes.delete(node.identifier)
        end
      end
    end
  end
end