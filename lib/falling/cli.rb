require 'thor'
require 'curses'


module Falling
  class Cli < Thor
    desc "start_game", "start a new game of Falling"
    def start_game()
      x = 10
      y = 3
      Curses.init_screen
      begin
        Curses.crmode
        Curses.noecho

        map = Curses::Window.new(
          Curses.lines, Curses.cols * 3 / 5,
          0, 0
        )
        map.setpos(0, 0)

        messages = Curses::Window.new(
          Curses.lines, Curses.cols * 2 / 5,
          0, Curses.cols * 3 / 5
        )
        messages.setpos(0, 0)

        map.noutrefresh
        messages.noutrefresh
        Curses.doupdate
      ensure
        Curses.close_screen
      end
    end
  end
end
