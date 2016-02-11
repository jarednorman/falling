# frozen_string_literal: true
require 'curses'

module Falling
  class View
    def initialize
      calculate_geometry!
      @window = Curses::Window.new(height, width, row, column)
    end

    def refresh
      window.noutrefresh
    end

    private

    attr_reader :window,
                :width,
                :height,
                :column,
                :row

    def calculate_geometry!
      raise NotImplementedError
    end
  end
end
