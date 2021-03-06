# frozen_string_literal: true

module ConsoleTracker
  class << self
    def configure
      yield(config)
    end

    def config
      @config ||= Config.new
    end
  end

  class Config
    attr_accessor :authenticator, :authenticator_settings, :logger, :logger_settings
  end
end
