# frozen_string_literal: true
require 'falling/node/references_proxy'

module Falling
  class Node
    class References
      def initialize(node, name, inverse: false)
        @node = node
        @name = name
        @identifiers = Set.new
        @inverse = inverse
      end

      def fetch
        ReferencesProxy.new node: node,
                            identifiers: identifiers,
                            inverse: inverse
      end

      private

      attr_reader :node,
                  :name,
                  :identifiers,
                  :inverse
    end
  end
end
