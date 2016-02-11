# frozen_string_literal: true
require 'falling/node'

module Falling
  class Area
    attr_reader :width,
                :height

    def initialize(width:,
                   height:)
      @width = width
      @height = height
    end

    def to_a
      @garbage ||=
        (1..height).map do
          (1..width).map { %w(# . . .).sample }.join
        end
    end
  end
end
