# frozen_string_literal: true

require('trailblazer/operation')
require('trailblazer/macro')
require('console_tracker/authenticators')

module ConsoleTracker
  class Authenticate < Trailblazer::Operation
    step :user
    step Nested(:authenticate_operation)
    fail :close_console

    pass :success_message

    def user(_ctx, **)
      username = STDIN.getpass('Username:')
      ConsoleTracker.user.name = username
    end

    def authenticate_operation(_ctx, **)
      ConsoleTracker::AUTHENTICATORS[ConsoleTracker.config.client]
    end

    def close_console(_ctx, error:, **)
      abort(error)
    end

    def success_message(_ctx, **)
      puts('You have successfully logged in.')
    end
  end
end
