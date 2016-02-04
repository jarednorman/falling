require 'test_helper'

module Falling
  class UniverseTest < Minitest::Test
    def setup
      @universe = Universe.new
    end

    def test_adding_fetching_and_removing_nodes
      candelabra = mock_node
      assert_nil @universe.fetch_node(candelabra.identifier)
      @universe.add_node(candelabra)
      assert_equal candelabra, @universe.fetch_node(candelabra.identifier)
      assert_equal candelabra, @universe.remove_node(candelabra)
      assert_nil @universe.remove_node(candelabra)
      assert_nil @universe.fetch_node(candelabra.identifier)
    end

    private

    def mock_node
      Object.new.tap do |node|
        identifier = SecureRandom.uuid
        node.define_singleton_method(:identifier) { identifier }
      end
    end
  end
end
