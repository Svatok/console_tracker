# frozen_string_literal: true

require('console_tracker/authenticators/cognito/authenticate')

module ConsoleTracker
  AUTHENTICATORS = {
    cognito: Authenticators::Cognito::Authenticate
  }.freeze
end
