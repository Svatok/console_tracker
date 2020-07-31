# frozen_string_literal: true

require('console_tracker/loggers/slack')

module ConsoleTracker
  LOGGERS = {
    slack: Loggers::SlackLogger
  }.freeze
end
