require 'spec_helper'

describe NNEClient::Trade do
  let(:trade_hash) do
    {
      :"@xsi:type" => "ns0:Trade",
      :primary     => true,
      :trade_code  => "471900",
      :@id         => "ID2",
      :trade       => "Anden detailhandel fra ikke-specialiserede forretninger"
    }
  end

  subject { NNEClient::Trade.new(trade_hash) }

  it               { should be_primary }
  it               { should eq NNEClient::Trade.new(trade_hash) }
  its(:trade_code) { should == trade_hash[:trade_code] }
  its(:trade)      { should == trade_hash[:trade] }

end
