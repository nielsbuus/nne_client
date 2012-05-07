require 'spec_helper'
require 'nne_client'

describe NNEClient::Search do
  describe 'a search with a single match' do
    it 'searches' do
      VCR.use_cassette('search_lokalebasen', :match_requests_on => [:body]) do
        NNEClient::Search.new('Lokalebasen').result_set.first.company_name.should == 'Lokalebasen.DK A/S'
      end
    end
  end

  describe 'a search with multiple matches' do
    it 'searches' do
      VCR.use_cassette('search_lokale', :match_requests_on => [:body]) do
        NNEClient::Search.new('Lokale').result_set.first.company_name.should == 'Andelsselskabet De Lokale Boliger'
      end
    end
  end
end
