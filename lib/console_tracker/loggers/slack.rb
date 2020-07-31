# frozen_string_literal: true

require('slack-ruby-client')
require('console_tracker/loggers/slack/compose_message')

module ConsoleTracker
  module Loggers
    class SlackLogger
      attr_reader :logger_settings

      def initialize
        @logger_settings = ConsoleTracker.config.logger_settings
      end

      def message_composer
        ConsoleTracker::Slack::ComposeMessage
      end

      def log_command(message_params)
        message_params[:channel] = logger_settings[:channel]
        client.chat_postMessage(message_params)
      end

      private

      def client
        @client ||= ::Slack::Web::Client.new(token: logger_settings[:token])
      end
    end
  end
end
