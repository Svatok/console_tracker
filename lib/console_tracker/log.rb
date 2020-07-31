# frozen_string_literal: true

require('trailblazer/operation')
require('trailblazer/macro')
require('console_tracker/loggers')

module ConsoleTracker
  class Log < Trailblazer::Operation
    step :username
    step :logger

    step :command_field
    step :developer_field
    step :attachments

    step :message
    step :send_message

    def username(ctx, **)
      ctx[:username] = ConsoleTracker.user.name || 'sdsd'
    end

    def logger(ctx, **)
      ctx[:logger] = ConsoleTracker::LOGGERS[ConsoleTracker.config.logger].new
    end

    def command_field(ctx, command:, **)
      ctx[:command_field] = {
        title: 'Command',
        value: "```#{command}```",
        short: false
      }
    end

    def developer_field(ctx, username:, **)
      ctx[:developer_field] = {
        title: 'Developer',
        value: "```#{username}```",
        short: false
      }
    end

    def attachments(ctx, **)
      ctx[:attachments] = [
        {
          fields: [ctx[:command_field], ctx[:developer_field]],
          color: '#e74c3c',
          footer: 'Console spy',
          footer_icon: 'https://drivy-prod-static.s3.amazonaws.com/slack/spy-small.png',
          ts: Time.zone.now.to_i,
          mrkdwn_in: ['fields']
        }
      ]
    end

    def message(ctx, attachments:, **)
      ctx[:message] = { attachments: attachments }
    end

    def send_message(_ctx, logger:, message:, **)
      logger.log_command(message)
    end
  end
end
