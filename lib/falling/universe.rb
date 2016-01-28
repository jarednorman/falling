require 'falling/area'

module Falling
  class Universe
    def active_area
      @active_area ||= Area.new(width: 64,
                                height: 32)
    end
  end
end
