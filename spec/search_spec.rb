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
    subject do
      soap_vcr('search_lokale') do
        NNEClient::Search.new(:name => 'Lokale').result_set
      end
    end

    it 'finds the company' do
      subject.first.official_name.should == 'Andelsselskabet De Lokale Boliger'
    end

    it 'knows the number of matches' do
      subject.total.should == 124
    end
  end

  describe 'asking for more results' do
    subject do
      soap_vcr('search_lokale_100') do
        NNEClient::Search.new(:name => 'Lokale', :hitsPerPage => 100).result_set
      end
    end

    it 'finds the company' do
      subject.first.official_name.should == 'Andelsselskabet De Lokale Boliger'
    end

    it 'fetches 100 records' do
      subject.count.should == 100
    end
  end

  describe "searching for something non existent" do
    subject do
      soap_vcr('search_for_noise') do
        NNEClient::Search.new(:name => 'asdfasdfasdf').result_set
      end
    end

    it 'has a total of 0 results' do
      subject.total.should == 0
    end

    it 'fetches 0 records' do
      subject.count.should == 0
    end

    it 'can iterate' do
      expect { |block|
        subject.each(&block)
      }.not_to yield_control
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
