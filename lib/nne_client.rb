require 'config_newton'
require 'savon'
require "nne_client/version"
require "nne_client/result_attributes"
require "nne_client/fetch"
require "nne_client/request"
require "nne_client/search"
require "nne_client/query"
require "nne_client/question"
require "nne_client/result"
require "nne_client/result_set"
require "nne_client/record_types/finance"
require "nne_client/record_types/ownership"
require "nne_client/record_types/subsidiary"
require "nne_client/record_types/trade"

# Namespace for the library
module NNEClient
  extend self
  include ConfigNewton

  class CompanyMissing < RuntimeError; end

  config :access_key
  config :http_read_timeout
  config :log, :default => false
  config :log_level, :default => :info
  config :logger

  # Where users start the interaction with the library.
  #
  # The query is hash with one or more of these keys:
  #
  # * :houseNo (string)
  # * :name (string)
  # * :nameStartsWith (boolean)
  # * :street (string)
  # * :zipCode (number)
  # * :tdcId (number)
  #
  # @return [ResultSet] containing the results from the SOAP API
  def search(query)
    NNEClient::Search.new(query).result_set
  end

  def with_timeout(seconds, &block)
    old_timeout = NNEClient.config.http_read_timeout
    NNEClient.config.http_read_timeout = seconds
    yield
  ensure
    NNEClient.config.http_read_timeout = old_timeout
  end

  def retry_timeouts(count, &block)
    retries = 3
    begin
      yield
    rescue Timeout::Error => e
      retries -= 1
      retry if retries > 0
    end
  end
end
