# frozen_string_literal: true
require 'curses'

require 'falling/view'
require 'falling/messaging/message'

module Falling
  class MessagesView < View
    MAX_MESSAGES = 64

    def initialize(universe:,
                   player: nil)
      Falling.logger.info "Initializing MapView."
      @universe = universe
      @player = player
      add_message(Messaging::Message.new("Welcome to Falling."))
      add_message(Messaging::Message.new("Press ? for help."))
      super()
    end

    def step!
      character = window.getch
      Falling.logger.debug "User input: #{character.inspect}."

      case character
      when "q"
        return false
      when "?"
        add_message(Messaging::Message.new(
                      "Controls:\n - q to quit\n - literally nothing else"
        ))
      end

      true
    end

    def add_message(message)
      messages.insert(0, message)
      messages.slice(0, MAX_MESSAGES)
    end

    def refresh
      window.clear
      window.box(0, 0)
      draw_messages
      super
    end

    private

    attr_reader :player

    def draw_messages
      offset = text_height
      messages.each do |message|
        message_height = message.height(at_width: text_width)
        offset -= message_height
        break if offset < 1
        message.format(for_width: text_width).each_with_index do |text, index|
          window.setpos offset + index, 1
          window.addstr text
        end
      end
      window.setpos text_height, 1
    end

    def calculate_geometry!
      @width = Curses.cols - Curses.cols * 3 / 5
      @height = Curses.lines
      @row = 0
      @column = Curses.cols * 3 / 5
    end

    def text_width
      width - 2
    end

    def text_height
      height - 2
    end

    def messages
      @messages ||= []
    end
  end
end
