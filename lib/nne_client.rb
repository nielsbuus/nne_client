require 'savon'
require "nne_client/version"
require "nne_client/fetch"
require "nne_client/request"
require "nne_client/search"
require "nne_client/query"
require "nne_client/question"
require "nne_client/result"
require "nne_client/result_set"

module NNEClient
  extend self

  def search(name)
    NNEClient::Search.new(name).result_set
  end

  def request(*attrs, &block)
    client.request(*attrs, &block)
  end

  private

  def wsdl_url
    'http://service.nnerhverv.dk/nne-ws/3.1/NNE?WSDL'
  end

  def client
    @client ||= Savon::Client.new(wsdl_url)
  end
end
