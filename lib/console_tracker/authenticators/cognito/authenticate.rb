# frozen_string_literal: true

require('trailblazer/operation')
require('trailblazer/macro')
require('console_tracker/authenticators/cognito')

module ConsoleTracker
  module Authenticators
    module Cognito
      class Authenticate < Trailblazer::Operation
        step :client

        step Rescue(StandardError, handler: :handle_exception!) {
          step :authenticate
          step :change_temporary_password?, Output(:failure) => End(:success)
          step :change_temporary_password
        }

        def client(ctx, **)
          ctx[:client] = CognitoAuthenticator.new
        end

        def authenticate(ctx, client:, **)
          password = STDIN.getpass('Password:')
          ctx[:authentication_response] = client.authenticate(password)
        end

        def change_temporary_password?(_ctx, authentication_response:, **)
          authentication_response.challenge_name == 'NEW_PASSWORD_REQUIRED'
        end

        def change_temporary_password(_ctx, client:, authentication_response:, **)
          puts('Please change temporary password')
          new_password = STDIN.getpass('New password:')
          client.change_temporary_password(authentication_response.session, new_password)
        end

        def handle_exception!(exception, (ctx), *)
          ctx[:error] = exception.message
        end
      end
    end
  end
end
