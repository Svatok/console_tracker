# frozen_string_literal: true

module ConsoleTracker
  class << self
    def user
      @user ||= User.new
    end
  end

  class User
    attr_accessor :name
  end
end
