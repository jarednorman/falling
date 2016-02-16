# frozen_string_literal: true
module Falling
  class Node
    class ReferencesProxy
      include Enumerable

      def initialize(node:,
                     identifiers:,
                     inverse:)
        @node = node
        @inverse = inverse
        @identifiers = identifiers
      end

      def each(&block)
        nodes.each(&block)
      end

      def add(node)
        identifiers.add(node.identifier)
        set_inverse_reference!(node)
      end

      def delete(node)
        identifiers.delete(node.identifier)
        unset_inverse_reference!(node)
      end

      private

      attr_reader :identifiers,
                  :node,
                  :inverse

      def nodes
        identifiers.map(&node.universe.method(:fetch_node))
      end

      def set_inverse_reference!(inverse_node)
        return unless inverse

        case (reference = inverse_reference(inverse_node))
        when Reference
          reference.set(node, force: true)
        when References
          raise NotImplementedError, "Many to many exceptions aren't supported yet."
        end
      end

      def unset_inverse_reference!(inverse_node)
        return unless inverse

        case (reference = inverse_reference(inverse_node))
        when Reference
          reference.set(nil, force: true)
        when References
          raise NotImplementedError, "Many to many exceptions aren't supported yet."
        end
      end

      def inverse_reference(inverse_node)
        unless inverse_node.respond_to? inverse_method
          raise MissingInverseReferenceError,
                "Inverse node was missing #{inverse.inspect} reference."
        end
        inverse_node.public_send inverse_method
      end

      def inverse_method
        "#{inverse}_reference"
      end
    end
  end
end
