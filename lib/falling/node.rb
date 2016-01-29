module Falling
  class Node
    attr_reader :identifier

    class << self
      def reference(name)
        define_method(name) do
          instance_variable_get("@#{name}")
        end

        define_method("#{name}=") do |value|
          instance_variable_set("@#{name}", value)
        end
      end
    end

    def initialize
      @identifier = SecureRandom.uuid
    end
  end
end
