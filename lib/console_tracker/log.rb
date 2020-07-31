# frozen_string_literal: true

require('trailblazer/operation')
require('trailblazer/macro')
require('console_tracker/loggers')

module ConsoleTracker
  class Log < Trailblazer::Operation
    step :username
    step :logger
    step Nested(:message_operation)
    step :send_message

    def username(ctx, **)
      ctx[:username] = ConsoleTracker.user.name
    end

    def logger(ctx, **)
      ctx[:logger] = ConsoleTracker::LOGGERS[ConsoleTracker.config.logger].new
    end

    def message_operation(_ctx, logger:, **)
      logger.message_composer
    end

    def send_message(_ctx, logger:, message_params:, **)
      logger.log_command(message_params)
    end
  end
end
