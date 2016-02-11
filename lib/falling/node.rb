# frozen_string_literal: true
require 'falling/node/reference'
require 'falling/node/references'

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
        reference_name = "@#{name}_reference"

        define_method(reference_name) do
          references[name] ||= References.new(self, name)
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
