require 'falling/player'

module Falling
  class Universe
    attr_reader :player

    def initialize(player: true)
      create_player!
    end

    private

    def create_player!
      @player = Player.new
    end
  end
end
