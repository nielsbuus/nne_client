require 'spec_helper'

describe NNEClient::Result do
  it "knows all names" do
    VCR.use_cassette('result_names', :match_requests_on => [:body]) do
      result = NNEClient::Result.new(:official_name => 'Name', :tdc_id => '100323228')
      result.additional_names.should == [
        "Tv Holbæk A/S",
        "A/S Trykkeriet Nordvest",
        "A/S Trykkeriet Nordvestsjælland",
        "Nordvestsjællands Media Selskab A/S",
        "Radio Holbæk A/S"
      ]
    end
  end
end
