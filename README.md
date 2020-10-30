# ConsoleTracker

`console_tracker` is tool for authentication users in console and tracking the commands they enter.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'console_tracker'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install console_tracker

## Usage

### Spring

`console_tracker` will not work with `Spring`. You must not install Spring on environment where you will use 
`console_tracker`. To prevent it from being installed, provide the `--without development test` argument to the `bundle install` command which is used to install gems:

```bash
$ bundle install --without development test
```

### Example of configuration with AWS Cognito authenticator and Slack logger

#### Step 1

Create file `config/initializers/console_tracker.rb`

```ruby
ConsoleTracker.configure do |config|
  config.client = :cognito
  config.client_settings = {
    region: ENV['region'],
    client_id: ENV['client_id'],
    access_key_id: ENV['AWS_KEY_ID'],
    secret_access_key: ENV['AWS_ACCESS_KEY']
  }
end

ConsoleTracker.start
```

#### Step 2

Create user in https://aws.amazon.com/cognito/

![Screenshot from 2020-10-30 09-12-37](https://user-images.githubusercontent.com/18479771/97674468-416cd480-1a96-11eb-95c7-fd51912dbc4a.png)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Svatok/console_tracker. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/Svatok/console_tracker/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT)

## Code of Conduct	

Everyone interacting in the ConsoleTracker project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/Svatok/console_tracker/blob/master/CODE_OF_CONDUCT.md).
