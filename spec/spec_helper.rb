require 'rubygems'
require 'vcr'
require 'nne_client'

HTTPI.log = false

Savon.configure do |config|
  config.log = false            # disable logging
  config.log_level = :info      # changing the log level
  # config.logger = Rails.logger  # using the Rails logger
end


VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr_cassettes'
  c.hook_into :fakeweb
end
