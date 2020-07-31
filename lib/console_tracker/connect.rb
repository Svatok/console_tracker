# frozen_string_literal: true

require('console_tracker/log')

module ConsoleTracker
  class << self
    def connect
      with_irb if defined?(IRB)
      with_pry if defined?(Pry)
    end

    def with_irb
      IRB::Context.class_eval do
        alias_method :usual_evaluate, :evaluate

        def evaluate(*params)
          usual_evaluate(*params)
          ConsoleTracker::Log.call(command: params.first)
        end
      end
    end

    def with_pry
      Pry.hooks.add_hook(:after_read, 'console_tracker') do |string, _pry|
        ConsoleTracker::Log.call(command: string)
      end
    end
  end
end
