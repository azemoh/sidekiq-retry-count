# Sidekiq::RetryCount

Sidekiq middleware to expose retry count inside jobs

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sidekiq-retry-count'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sidekiq-retry-count


## Configuration

In a Rails initializer or wherever you've configured Sidekiq, add
Sidekiq::RetryCount::Middleware to your server middleware:

```ruby
Sidekiq.configure_server do |config|
  config.server_middleware do |chain|
    chain.add Sidekiq::RetryCount::Middleware
  end
end
```

## Usage

In the worker, include Sidekiq::RetryCount and use the `retry_count` method

```ruby
class MyWorker
  include Sidekiq::Worker
  include Sidekiq::RetryCount

  sidekiq_options retry: 3

  def perform(*args)
    # Do something

  rescue StandardError => e
    if retry_count == 3
      # Do something special on the last try
    end
  end
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/azemoh/sidekiq-retry-count.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
