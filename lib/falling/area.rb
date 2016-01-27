module Falling
  class Area
    def to_a
      (1..256).map do
        (1..256).map { %w(# . . .).sample }.join
      end
    end
  end
end
