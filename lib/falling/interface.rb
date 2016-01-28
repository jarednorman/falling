require 'falling/map_view'
require 'falling/messages_view'
require 'falling/player'

module Falling
  class Interface
    attr_reader :player

    def initialize(universe:,
                   player: true)
      create_player! if player
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

    def with_screen
      Falling.logger.info "Initializing screen."
      Curses.init_screen
      begin
        Curses.crmode
        Curses.noecho
        yield
      ensure
        Falling.logger.info "Closing screen."
        Curses.close_screen
      end
    end

    def create_player!
      @player = Player.new
    end
  end
end
