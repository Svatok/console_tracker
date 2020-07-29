# frozen_string_literal: true

require('console_tracker/authenticators/cognito/sign_in')

module ConsoleTracker
  AUTHENTICATORS = {
    cognito: Authenticators::Cognito::SignIn
  }.freeze
end
