require 'falling/area'

module Falling
  class Universe
    def fetch_node(identifier)
      nodes[identifier]
    end

    def add_node(node)
      nodes[node.identifier] = node
    end

    def remove_node(node)
      nodes.delete(node.identifier)
    end

    def active_area
      @active_area ||= Area.new(width: 256, height: 32)
    end

    private

    def nodes
      @nodes ||= {}
    end
  end
end
