require 'falling/area'

module Falling
  class Universe
    def active_area
      @active_area ||= Area.new(width: 256, height: 32)
    end
  end
end
