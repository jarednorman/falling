require 'falling/node/references_proxy'

module Falling
  class Node
    class References
      def initialize(node, name)
        @node = node
        @name = name
        @identifiers = Set.new
      end

      def fetch
        ReferencesProxy.new node, identifiers
      end

      private

      attr_reader :node,
                  :name,
                  :identifiers
    end
  end
end
