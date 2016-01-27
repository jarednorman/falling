require 'curses'

require 'falling/version'
require 'falling/universe'
require 'falling/interface'

module Falling
  class << self
    def start_game
      Interface.new(universe: Falling::Universe.new).run!
    end
  end
end
