# frozen_string_literal: true
require 'curses'

require 'falling/view'

module Falling
  class MapView < View
    def initialize(universe:,
                   player: nil)
      Falling.logger.info "Initializing MapView."
      @universe = universe
      @player = player
      super()
    end

    # FIXME: Add smart camera centering.
    def refresh
      active_area.
        to_a[0, height].
        each_with_index do |row_string, row_index|
          window.setpos row_offset + row_index, column_offset
          window.addstr row_string[0, width]
        end

      super
    end

    private

    attr_reader :universe,
                :player

    def active_area
      universe.active_area
    end

    def column_offset
      if active_area.width <= width
        (width - active_area.width) / 2
      else
        0
      end
    end

    def row_offset
      if active_area.height <= height
        (height - active_area.height) / 2
      else
        0
      end
    end

    def calculate_geometry!
      @width = Curses.cols * 3 / 5
      @height = Curses.lines
      @row = 0
      @column = 0
    end
  end
end
