# Cinch::Plugins::Seen

Cinch Plugin to allow users to ask the bot when the last time it saw a given user was.

## Installation

Add this line to your application's Gemfile:

    gem 'cinch-seen'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cinch-seen

## Usage

Just add the plugin to your list:

    @bot = Cinch::Bot.new do
      configure do |c|
        c.plugins.plugins = [Cinch::Plugins::Seen]
      end
    end

Then in channel use .seen

    .seen username


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
