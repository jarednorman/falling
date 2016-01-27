require 'curses'

module Falling
  class MapView
    def initialize(universe:)
      @universe = universe
      @window = Curses::Window.new(
        Curses.lines, Curses.cols * 3 / 5,
        0, 0
      )
    end

    def refresh
      window.noutrefresh
    end

    private

    attr_reader :window
  end
end
