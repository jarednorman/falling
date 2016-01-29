module Falling
  class Node
    attr_reader :identifier

    def initialize
      @identifier = SecureRandom.uuid
    end
  end
end
