require 'curses'

module Falling
  class MessagesView
    def initialize(universe:)
      @universe = universe

      @window = Curses::Window.new(
        Curses.lines, Curses.cols * 2 / 5,
        0, Curses.cols * 3 / 5
      )
    end

    def step!
      window.getch
    end

    def refresh
      window.noutrefresh
    end

    private

    attr_reader :window
  end
end
