module Falling
  class Node
    attr_reader :identifier

    class << self
      attr_accessor :universe

      def reference(name)
        variable_name = "@#{name}_identifier"

        define_method(name) do
          universe.fetch_node(instance_variable_get(variable_name))
        end

        define_method("#{name}=") do |value|
          instance_variable_set(variable_name, value.identifier)
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

    private

    def universe
      Node.universe
    end
  end
end
