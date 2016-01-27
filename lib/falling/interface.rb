require 'falling/map_view'
require 'falling/messages_view'

module Falling
  class Interface
    def initialize(universe:)
      @universe = universe
    end

    def run!
      with_screen do
        loop do
          map_view.refresh
          messages_view.refresh
          Curses.doupdate
          break unless messages_view.step!
        end
      end
    end

    private

    attr_reader :universe

    def map_view
      @map_view ||= MapView.new(universe: universe)
    end

    def messages_view
      @messages_view ||= MessagesView.new(universe: universe)
    end

    private

    def with_screen
      Curses.init_screen
      begin
        Curses.crmode
        Curses.noecho
        yield
      ensure
        Curses.close_screen
      end
    end
  end
end
