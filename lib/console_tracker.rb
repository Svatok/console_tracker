# frozen_string_literal: true

require('console_tracker/version')
require('console_tracker/authenticators')
require('console_tracker/configure')

module ConsoleTracker
  class << self
    def start
      result = ConsoleTracker::AUTHENTICATORS[config.client].call
      if result.success?
        puts('You have successfully logged in.')
      else
        abort(result[:error])
      end
    end
  end
end
