require 'falling/player'
require 'falling/area'

module Falling
  class Universe
    attr_reader :player

    def initialize(player: true)
      create_player! if player
    end

    def active_area
      Area.new
    end

    private

    def create_player!
      @player = Player.new
    end
  end
end
