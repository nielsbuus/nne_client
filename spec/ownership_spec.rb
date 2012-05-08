require 'spec_helper'

describe NNEClient::Ownership do
  let(:ownership_hash) do
    {
      :country     => "Holland",
      :"@xsi:type" => "ns0:Ownership",
      :share       => "100            ",
      :tdc_id      => "0",
      :@id         => "ID2",
      :name        => "Ingka Holding Scandinavia Bv"
    }
  end

  subject { NNEClient::Ownership.new(ownership_hash) }

  it            { should eq NNEClient::Ownership.new(ownership_hash) }
  its(:share)   { should == '100' }
  its(:name)    { should == ownership_hash[:name] }
  its(:country) { should == ownership_hash[:country] }

end
