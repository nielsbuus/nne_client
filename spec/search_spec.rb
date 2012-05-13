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

  describe 'with an access key' do
    before(:each) do
      NNEClient.configure { |config| config.access_key = 'some key' }
    end

    it 'finds the company' do
      soap_vcr('search_lokalebasen_with_access_key') do
        NNEClient::Search.new(:name => 'Lokalebasen').result_set.first.official_name.should == 'Lokalebasen.DK A/S'
      end
    end
  end
end
