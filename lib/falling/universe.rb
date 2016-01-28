require 'falling/area'

module Falling
  class Universe
    def active_area
      @active_area ||= Area.new
    end
  end
end
