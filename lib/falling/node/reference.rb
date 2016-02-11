module Falling
  class Node
    class Reference
      def initialize(node, name, inverse: false)
        @node = node
        @name = name
        @inverse = inverse
      end

      def set(node, force: false)
        self.identifier = node.identifier
        set_inverse_reference! unless force
      end

      def fetch
        universe.fetch_node(identifier)
      end

      private

      attr_reader :node,
                  :name,
                  :inverse

      attr_accessor :identifier

      def set_inverse_reference!
        return unless inverse

        unless fetch.respond_to? inverse
          raise MissingInverseReferenceError,
            "Inverse node was missing #{inverse.inspect} reference."
        end

        fetch.
          public_send("#{inverse}_reference").
          set(node, force: true)
      end

      def universe
        node.universe
      end
    end
  end
end
