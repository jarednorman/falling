require 'curses'
require 'logger'
require 'tempfile'

require 'falling/version'
require 'falling/universe'
require 'falling/interface'

module Falling
  class << self
    def start_game
      Interface.new(universe: Falling::Universe.new).run!
    ensure
      log_file.close
      log_file.unlink if log_file.is_a? Tempfile
    end

    def logger
      @logger ||=
        Logger.new(log_file).tap do |logger|
          logger.level =
            if development?
              Logger::DEBUG
            else
              Logger::WARN
            end
        end
    end

    private

    def log_file
      @log_file ||=
        if development?
          File.open('./development.log', File::WRONLY | File::APPEND | File::CREAT)
        else
          Tempfile.new('falling.log')
        end
    end

    def development?
      ENV['FALLING_ENV'] == 'development'
    end
  end
end
