# frozen_string_literal: true
module Falling
  class Node
    class ReferencesProxy
      include Enumerable

      def initialize(node, identifiers)
        @node = node
        @identifiers = identifiers
      end

      def each(&block)
        nodes.each(&block)
      end

      def add(node)
        identifiers.add(node.identifier)
      end

      def delete(node)
        identifiers.delete(node.identifier)
      end

      private

      def nodes
        identifiers.map(&node.universe.method(:fetch_node))
      end

      attr_reader :identifiers,
                  :node
    end
  end
end
