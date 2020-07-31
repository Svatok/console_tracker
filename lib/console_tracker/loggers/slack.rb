# frozen_string_literal: true

require('slack-ruby-client')

module ConsoleTracker
  module Loggers
    class Slack
      attr_reader :logger_settings

      def initialize
        @logger_settings = ConsoleTracker.config.logger_settings
      end

      def log_command(message)
        message = message.merge(
          channel: logger_settings[:channel],
          text: ''
        )
        client.chat_postMessage(message)
      end

      private

      def client
        @client ||= ::Slack::Web::Client.new(token: logger_settings[:token])
      end
    end
  end
end
