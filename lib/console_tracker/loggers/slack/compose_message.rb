# frozen_string_literal: true

require('trailblazer/operation')
require('trailblazer/macro')

module ConsoleTracker
  module Slack
    class ComposeMessage < Trailblazer::Operation
      step :text
      step :attachment
      step :command_field

      step :message_params

      def text(ctx, username:, **)
        ctx[:text] = "*DEVELOPER: _#{username}_*"
      end

      def attachment(ctx, **)
        ctx[:attachment] = {
          fields: [],
          color: '#e74c3c',
          footer: 'Console spy',
          footer_icon: 'https://drivy-prod-static.s3.amazonaws.com/slack/spy-small.png',
          ts: Time.zone.now.to_i,
          mrkdwn_in: ['fields']
        }
      end

      def command_field(_ctx, attachment:, command:, **)
        attachment[:fields] << {
          title: 'Command',
          value: "```#{command}```",
          short: false
        }
      end

      def message_params(ctx, attachment:, text:, **)
        ctx[:message_params] = { text: text, attachments: [attachment] }
      end
    end
  end
end
