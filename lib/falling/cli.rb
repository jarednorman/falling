# frozen_string_literal: true
require 'thor'
require 'falling'

module Falling
  class Cli < Thor
    desc 'start_game', 'start a new game of Falling'
    def start_game
      Falling.start_game
    end
  end
end
