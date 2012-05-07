require 'savon'
require "nne_client/version"
require "nne_client/search"
require "nne_client/result"
require "nne_client/result_set"

module NNEClient
  extend self

  def search(name)
    NNEClient::Search.new(name).result_set
  end
end
