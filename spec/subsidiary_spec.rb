require 'spec_helper'

describe NNEClient::Subsidiary do
  let(:subsidiary_hash) do
    {
      :country     => "Holland",
      :"@xsi:type" => "ns0:Subsidiary",
      :share       => "100            ",
      :tdc_id      => "123",
      :@id         => "ID2",
      :name        => "Ingka Holding Scandinavia Bv"
    }
  end

  subject { NNEClient::Subsidiary.new(subsidiary_hash) }

  it            { should eq NNEClient::Subsidiary.new(subsidiary_hash) }
  its(:share)   { should == '100' }
  its(:name)    { should == subsidiary_hash[:name] }
  its(:country) { should == subsidiary_hash[:country] }

  describe "#company" do
    let(:company)    { double(:company) }
    let(:result_set) { double(:result_set, :first => company) }
    let(:search)     { double(:search, :result_set => result_set) }

    it "knows how to fetch company information" do
      NNEClient::Search.should_receive(:new).with(:tdcId => '123') { search }
      subject.company
    end
    it "knows how to fetch company information" do
      NNEClient::Search.stub(:new) { search }
      subject.company.should == company
    end
  end

end

