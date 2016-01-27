require 'curses'

require 'falling/view'

module Falling
  class MapView < View
    def initialize(universe:)
      @universe = universe
      super()
    end

    def refresh
      universe.
        active_area.
        to_a[0, height].
        each_with_index do |row_string, row_index|
          window.setpos row_index, 0
          window.addstr row_string[0, width]
        end

      super
    end

    private

    attr_reader :universe

    def calculate_geometry!
      @width = Curses.cols * 3 / 5
      @height = Curses.lines
      @row = 0
      @column = 0
    end
  end
end
