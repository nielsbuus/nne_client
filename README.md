# NNEClient

Client library for interacting with the "Navne & Numre Erhverv" SOAP API.

## Installation

Add this line to your application's Gemfile:

    gem 'nne_client'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nne_client

## Usage

If you need to provide an access key configure NNE Client with:

    NNEClient.configure do |config|
      config.access_key = 'some key'
    end

Searching for a company:

    result_set = NNEClient.search(:name => 'Lokalebasen')
    result_set.first.official_name
      => "Lokalebasen.dk A/S"

So far the following keys can be used for searching:

    :houseNo (string)
    :name (string)
    :nameStartsWith (boolean)
    :street (string)
    :zipCode (number)
    :tdcId (number)

Each entry in the result\_set has the following methods available for accessing
information about the company:

    ad_protection
    cvr_no
    district
    email
    founded_year
    homepage
    number_of_employees
    official_name
    p_no
    phone
    status_text
    street
    tdf_name
    zip_code

Additionally further information can be fetched through the methods:

    additional_names
    trades
    associates
    ownerships
    subsidiaries
    finances

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
