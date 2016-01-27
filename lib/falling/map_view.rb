require 'curses'

require 'falling/view'

module Falling
  class MapView < View
    def initialize(universe:)
      @universe = universe
      super()
    end

    def refresh
      window.setpos 1, 1
      window.addstr rand.to_s
      super
    end

    private

    def calculate_geometry!
      @width = Curses.cols * 3 / 5
      @height = Curses.lines
      @row = 0
      @column = 0
    end
  end
end
