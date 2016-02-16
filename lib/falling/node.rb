# frozen_string_literal: true
require 'falling/node/reference'
require 'falling/node/references'

module Falling
  # Node is the superclass for representing anything that exists concretely in
  # the Falling universe (a chair, a sword, a person, a tile).
  class Node
    # Raised when a write is attempted on an inverse that doesn't exist.
    class MissingInverseReferenceError < StandardError; end

    # @return [String] the node's unique identifier
    attr_reader :identifier

    class << self
      # @return [Falling::Universe]
      attr_accessor :universe

      # Adds a one-to-one reference to this class
      # @param name [Symbol] the name of the reference
      # @option options [Symbol] inverse the name of the inverse reference
      def reference(name, *options)
        reference_name = "#{name}_reference"

        define_method(reference_name) do
          references[name] ||= Reference.new(self, name, *options)
        end

        define_method(name) do
          public_send(reference_name).fetch
        end

        define_method("#{name}=") do |node|
          public_send(reference_name).set node
        end
      end

      # Adds a one-to-many reference to this class
      # @param name [Symbol] the name of the reference
      def references(name, *options)
        reference_name = "@#{name}_reference"

        define_method(reference_name) do
          references[name] ||= References.new(self, name, *options)
        end

        define_method(name) do
          public_send(reference_name).fetch
        end
      end
    end

    def initialize
      @identifier = SecureRandom.uuid
      universe.add_node(self)
    end

    # Destroys this node, removing it from the universe
    def destroy!
      universe.remove_node(self)
    end

    # @return [Falling::Universe] the universe that this node exists in
    def universe
      Node.universe
    end

    private

    def references
      @references ||= {}
    end
  end
end
