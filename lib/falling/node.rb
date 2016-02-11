require 'falling/node/reference'

module Falling
  class Node
    class MissingInverseReferenceError < StandardError; end

    attr_reader :identifier

    class << self
      attr_accessor :universe

      def reference(name, *arguments)
        reference_name = "#{name}_reference"

        define_method(reference_name) do
          references[name] ||= Reference.new(self, name, *arguments)
        end

        define_method(name) do
          public_send(reference_name).fetch
        end

        define_method("#{name}=") do |node|
          public_send(reference_name).set node
        end
      end

      def references(name)
        variable_name = "@#{name}_identifiers"
        identifiers_getter_name = "#{name}_identifiers"
        insert_name = "insert_#{name}"
        delete_name = "delete_#{name}"

        define_method(identifiers_getter_name) do
          instance_variable_set(
            variable_name,
            instance_variable_get(variable_name) || Set.new
          )
        end

        define_method(name) do
          Set.new public_send(identifiers_getter_name).map do |identifier|
            universe.fetch_node(identifier)
          end
        end

        define_method(insert_name) do |node|
          public_send(identifiers_getter_name) << node.identifier
        end

        define_method(delete_name) do |node|
          public_send(identifiers_getter_name).delete(node.identifier)
        end
      end
    end

    def initialize
      @identifier = SecureRandom.uuid
      universe.add_node(self)
    end

    def destroy!
      universe.remove_node(self)
    end

    def universe
      Node.universe
    end

    private

    def references
      @references ||= {}
    end
  end
end
