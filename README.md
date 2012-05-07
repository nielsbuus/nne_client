# NneClient

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'nne_client'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nne_client

## Usage

Searching for a company:

    result_set = NNEClient.search(:name => 'Lokalebasen')
    result_set.first.official_name
      => "Lokalebasen.dk A/S"

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
