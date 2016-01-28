module Falling
  module Messaging
    class Message
      def initialize(text)
        @text = text
      end

      def height(at_width:)
        raise "not enough screen space" if at_width < 24
        format(for_width: at_width).length
      end

      def format(for_width:)
        text.scan(/.{1,#{for_width}}/)
      end

      private

      attr_reader :text
    end
  end
end
