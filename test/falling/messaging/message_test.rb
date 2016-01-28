require 'test_helper'

module Falling
  module Messaging
    class MessageTest < Minitest::Test
      def test_format_breaks_lines
        message = Message.new('1234567890ABCDEF')
        assert_equal ['1234567890ABCDEF'], message.format(for_width: 16)
        assert_equal %w(12345678 90ABCDEF), message.format(for_width: 8)
      end
    end
  end
end
