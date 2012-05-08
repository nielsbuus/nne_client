require 'spec_helper'

describe NNEClient::Subsidiary do
  let(:subsidiary_hash) do
    {
      :country     => "Holland",
      :"@xsi:type" => "ns0:Subsidiary",
      :share       => "100            ",
      :tdc_id      => "0",
      :@id         => "ID2",
      :name        => "Ingka Holding Scandinavia Bv"
    }
  end

  subject { NNEClient::Subsidiary.new(subsidiary_hash) }

  it            { should eq NNEClient::Subsidiary.new(subsidiary_hash) }
  its(:share)   { should == '100' }
  its(:name)    { should == subsidiary_hash[:name] }
  its(:country) { should == subsidiary_hash[:country] }

end

