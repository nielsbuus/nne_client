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
    context "with an access key" do
      around(:each) do |example|
        NNEClient.configure { |config| config.access_key = 'some key' }
        soap_vcr('result_extended_info_with_access_key') do
          example.run
        end
        NNEClient.configure { |config| config.access_key = nil }
      end

      its(:email)               { should == 'jacob@incremental.dk' }
      its(:homepage)            { should be_nil }
      its(:founded_year)        { should == '2009' }
      its(:number_of_employees) { should == '0' }
      its(:tdf_name)            { should == 'Incremental' }
      its(:status_text)         { should == 'Selskabet er i normal drift.' }
    end

    context "without an access key" do
      around(:each) do |example|
        soap_vcr('result_extended_info') do
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
  end

  context "with a single trade" do
    around(:each) do |example|
      soap_vcr('result_trades') do
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
      soap_vcr('result_multiple_trades') do
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

  context "with no ownership information" do
    around(:each) do |example|
      soap_vcr('result_no_ownerships') do
        example.run
      end
    end

    subject { NNEClient::Result.new(result_hash) }

    its(:ownerships) { should be_empty }
  end

  context "with single ownership" do
    around(:each) do |example|
      soap_vcr('result_single_ownership') do
        example.run
      end
    end

    subject { NNEClient.search(:name => 'Ikea').first }

    its(:ownerships) {
      should include NNEClient::Ownership.new(
        :share => '100 ',
        :name => 'Ingka Holding Scandinavia Bv',
        :country => 'Holland'
      )
    }
  end

  context "with multiple ownership" do
    around(:each) do |example|
      soap_vcr('result_multiple_ownerships') do
        example.run
      end
    end

    subject { NNEClient.search(:tdcId => '100319964').first }

    its(:ownerships) {
      should include NNEClient::Ownership.new(
        :share => '33 ',
        :name => 'Henrik Harald Halberg',
        :country => nil
      )
    }
  end

  context "with no subsidiaries" do
    it "has no subsidiares" do
      soap_vcr('result_no_subsidiaries') do
        result = NNEClient.search(:tdcId => '100319964').first
        result.subsidiaries.should be_empty
      end
    end
  end

  context "with a single subsidiary" do
    it "returns the subsidiary" do
      soap_vcr('result_single_subsidiary') do
        NNEClient.search(:name => 'Ikea').first.subsidiaries.should eq [
          NNEClient::Subsidiary.new(
            :country => "Danmark",
            :share => "100",
            :name => "Ikea Ejendomme ApS"
          )
        ]
      end
    end
  end

  context 'with no finances' do
    it "returns an empty array of finances" do
      soap_vcr('result_no_finance') do
        NNEClient.search(:name => 'Incremental').first.finances.should be_empty
      end
    end
  end

  context 'with a single finance record' do
    it "has a finance record" do
      soap_vcr('result_single_finance') do
        records = NNEClient.search(:name => 'Etech').first.finances
        records.map(&:year).should == ['2010']
      end
    end
  end

  context 'with multiple finance records' do
    it "has several finance records" do
      soap_vcr('result_multiple_finances') do
        records = NNEClient.search(:name => 'Ikea').first.finances
        records.map(&:year).should == ["2011", "2010", "2009", "2008", "2007"]
      end
    end
  end

  it "knows all names" do
    soap_vcr('result_names') do
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
    soap_vcr('result_names_empty') do
      result = NNEClient::Result.new(:official_name => 'Name', :tdc_id => '202541543')
      result.additional_names.should == []
    end
  end
end
