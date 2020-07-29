# frozen_string_literal: true

require('console_tracker/version')
require('console_tracker/configure')
require('console_tracker/user')
require('console_tracker/authenticate')

module ConsoleTracker
  class << self
    def start
      return unless defined?(Rails::Console)

      ConsoleTracker::Authenticate.call
    end
  end
end
