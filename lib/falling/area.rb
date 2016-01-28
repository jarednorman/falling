module Falling
  class Area
    def initialize
    end

    def to_a
      @garbage ||=
        (1..256).map do
          (1..256).map { %w(# . . .).sample }.join
        end
    end
  end
end
