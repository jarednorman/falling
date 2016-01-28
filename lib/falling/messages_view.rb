require 'curses'

require 'falling/view'

module Falling
  class MessagesView < View
    def initialize(universe:)
      @universe = universe
      super()
    end

    def step!
      window.getch != "q"
    end

    def refresh
      window.box(0, 0)
      super
    end

    private

    def calculate_geometry!
      @width = Curses.cols - Curses.cols * 3 / 5
      @height = Curses.lines
      @row = 0
      @column = Curses.cols * 3 / 5
    end
  end
end
