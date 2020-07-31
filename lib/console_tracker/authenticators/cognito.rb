# frozen_string_literal: true

require('aws-sdk-cognitoidentityprovider')

module ConsoleTracker
  module Authenticators
    class CognitoAuthenticator
      attr_reader :username, :authenticator_settings

      def initialize
        @username = ConsoleTracker.user.name
        @authenticator_settings = ConsoleTracker.config.authenticator_settings
      end

      def authenticate(password)
        client.initiate_auth(
          auth_flow: 'USER_PASSWORD_AUTH',
          auth_parameters: {
            USERNAME: username,
            PASSWORD: password
          },
          client_id: client_id
        )
      end

      def change_temporary_password(session, new_password)
        client.respond_to_auth_challenge(
          challenge_name: 'NEW_PASSWORD_REQUIRED',
          challenge_responses: {
            USERNAME: username,
            NEW_PASSWORD: new_password
          },
          client_id: client_id,
          session: session
        )
      end

      private

      def client
        @client ||= Aws::CognitoIdentityProvider::Client.new(
          region: authenticator_settings[:region],
          access_key_id: authenticator_settings[:access_key_id],
          secret_access_key: authenticator_settings[:secret_access_key]
        )
      end

      def client_id
        @client_id ||= authenticator_settings[:client_id]
      end
    end
  end
end
