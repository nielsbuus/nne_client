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

module NNEClient
  extend self

  def search(name)
    NNEClient::Search.new(name).result_set
  end
end
