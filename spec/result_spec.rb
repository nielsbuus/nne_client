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

  it "is an empty array if no additinal names present" do
    VCR.use_cassette('result_names_empty', :match_requests_on => [:body]) do
      result = NNEClient::Result.new(:official_name => 'Name', :tdc_id => '202541543')
      result.additional_names.should == []
    end
  end
end
