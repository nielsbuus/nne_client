require 'spec_helper'
require 'nne_client'

describe NNEClient::Search do
  describe 'a search with a single match' do
    it 'finds the company' do
      soap_vcr('search_lokalebasen') do
        NNEClient::Search.new(:name => 'Lokalebasen').result_set.first.official_name.should == 'Lokalebasen.DK A/S'
      end
    end
  end

  describe 'a search with multiple matches' do
    it 'finds the company' do
      soap_vcr('search_lokale') do
        NNEClient::Search.new(:name => 'Lokale').result_set.first.official_name.should == 'Andelsselskabet De Lokale Boliger'
      end
    end
  end
end
