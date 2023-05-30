module Sidekiq
  module RetryCount
    # Sidekiq middleware to expose retry count inside jobs
    class Middleware
      def call(worker, msg, _queue)
        if worker.respond_to?(:retry_count=)
          # retry_count =  nil, 0, 1, 2, 3..., First run is nil while first retry is 0th
          worker.retry_count = msg.fetch('retry_count', -1) + 1
        end

        yield
      end
    end
  end
end
