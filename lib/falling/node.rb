module Falling
  class Node
    class MissingInverseReferenceError < StandardError; end

    class ReferencesProxy
    end

    attr_reader :identifier

    class << self
      attr_accessor :universe

      def reference(name, inverse: false)
        variable_name = "@#{name}_identifier"
        setter_name = "set_#{name}"
        inverse_setter_name = "set_#{inverse}" if inverse

        define_method(name) do
          universe.fetch_node(instance_variable_get(variable_name))
        end

        define_method("#{name}=") do |value|
          public_send(setter_name, value)

          if inverse_setter_name
            raise MissingInverseReferenceError unless value.respond_to? inverse_setter_name

            value.public_send(inverse_setter_name, self)
          end
        end

        define_method(setter_name) do |value|
          instance_variable_set(variable_name, value.identifier)
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

    private

    def universe
      Node.universe
    end
  end
end
