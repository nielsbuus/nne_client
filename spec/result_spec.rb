require 'spec_helper'

describe NNEClient::Result do

  let(:result_hash) do
    {
      :p_no          => "1015150161",
      :fax           => {:"@xsi:type" => "xsd:string"},
      :ad_protection => "0",
      :tdc_id        => "202541543",
      :"@xsi:type"   => "ns0:CompanyBasic",
      :phone         => "26256502",
      :company_id    => "4218680",
      :official_name => "Incremental V/ Jacob Atzen",
      :street        => "Bygmestervej 47 3 tv",
      :zip_code      => "2400",
      :company_type  => "PL",
      :@id           => "ID4",
      :cvr_no        => "31999529",
      :district      => "København NV"
    }
  end

  subject { NNEClient::Result.new(result_hash) }

  its(:cvr_no)        { should == result_hash[:cvr_no] }
  its(:p_no)          { should == result_hash[:p_no] }
  its(:district)      { should == result_hash[:district] }
  its(:official_name) { should == result_hash[:official_name] }
  its(:phone)         { should == result_hash[:phone] }
  its(:street)        { should == result_hash[:street] }
  its(:zip_code)      { should == result_hash[:zip_code] }
  its(:ad_protection) { should == result_hash[:ad_protection] }

  context "with extended info" do
    around(:each) do |example|
      VCR.use_cassette('result_extended_info', :match_requests_on => [:soap_body_matcher]) do
        example.run
      end
    end

    its(:email)               { should == 'jacob@incremental.dk' }
    its(:homepage)            { should be_nil }
    its(:founded_year)        { should == '2009' }
    its(:number_of_employees) { should == '0' }
    its(:tdf_name)            { should == 'Incremental' }
    its(:status_text)         { should == 'Selskabet er i normal drift.' }
  end

  context "with a single trade" do
    around(:each) do |example|
      VCR.use_cassette('result_trades', :match_requests_on => [:soap_body_matcher]) do
        example.run
      end
    end

    its(:trades) {
      should eq [
        NNEClient::Trade.new(
          :primary => true,
          :trade => 'Konsulentbistand vedrørende informationsteknologi',
          :trade_code => '620200'
        )
      ]
    }
  end

  context "with multiple trades" do
    around(:each) do |example|
      VCR.use_cassette('result_multiple_trades', :match_requests_on => [:soap_body_matcher]) do
        example.run
      end
    end

    subject do NNEClient.search(:name => 'Dansk Supermarked').to_a[5] end

    its(:trades) {
      should include NNEClient::Trade.new(
        :primary => true,
        :trade => "Anden detailhandel fra ikke-specialiserede forretninger",
        :trade_code => "471900"
      )
    }

    its(:trades) {
      should include NNEClient::Trade.new(
        :primary => false,
        :trade => "Discountforretninger",
        :trade_code => "471130"
      )
    }
  end

  it "knows all names" do
    VCR.use_cassette('result_names', :match_requests_on => [:soap_body_matcher]) do
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
    VCR.use_cassette('result_names_empty', :match_requests_on => [:soap_body_matcher]) do
      result = NNEClient::Result.new(:official_name => 'Name', :tdc_id => '202541543')
      result.additional_names.should == []
    end
  end
end
