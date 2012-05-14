require 'spec_helper'

describe NNEClient::Ownership do
  let(:ownership_hash) do
    {
      :country     => "Holland",
      :"@xsi:type" => "ns0:Ownership",
      :share       => "100            ",
      :tdc_id      => "123",
      :@id         => "ID2",
      :name        => "Ingka Holding Scandinavia Bv"
    }
  end

  subject { NNEClient::Ownership.new(ownership_hash) }

  it            { should eq NNEClient::Ownership.new(ownership_hash) }
  its(:share)   { should == '100' }
  its(:name)    { should == ownership_hash[:name] }
  its(:country) { should == ownership_hash[:country] }

  describe "#company" do
    let(:result)     { double(:result) }

    it "knows how to fetch company information" do
      NNEClient::Result.should_receive(:new).with(:tdc_id => '123') { result }
      subject.company
    end
    it "knows how to fetch company information" do
      NNEClient::Result.stub(:new) { result }
      subject.company.should == result
    end
  end
end
