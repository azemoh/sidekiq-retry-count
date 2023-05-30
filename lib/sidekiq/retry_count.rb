require 'active_support/concern'

require 'sidekiq/retry_count/version'
require 'sidekiq/retry_count/middleware'

module Sidekiq
  module RetryCount
    extend ActiveSupport::Concern

    included do
      attr_accessor :retry_count
    end
  end
end
