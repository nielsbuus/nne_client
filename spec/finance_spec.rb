require 'spec_helper'

describe NNEClient::Finance do
  let(:hash) do
     {
       :contribution_ratio              => "26.02",
       :net_outcome                     => "132718.0",
       :stock                           => "136101.0",
       :assets                          => "1729700.0",
       :gross_profit                    => "789841.0",
       :return_on_assets                => "13.13",
       :"@xsi:type"                     => "ns0:Finance",
       :credit_rating                   => {:"@xsi:type" => "xsd:string"},
       :placings                        => "38837.0",
       :trade_debitors                  => "23232.0",
       :available_funds                 => "183991.0",
       :income_before_income_tax        => "188944.0",
       :share_holders_funds_of_interest => "78.96",
       :current_assets                  => "770605.0",
       :profit                          => "130000.0",
       :turnover                        => "3034952.0",
       :available_funds_ratio           => "74.48",
       :link_pdf                        => Date.parse('2012-03-30'),
       :shareholders_funds              => "168073.0",
       :depreciations                   => "-37525.0",
       :profit_for_the_year             => "132718.0",
       :@id                             => "ID2",
       :balance                         => "1729700.0",
       :long_termed_liability           => "488133.0",
       :short_termed_liability          => "1034657.0",
       :fixed_assets                    => "959095.0",
       :number_of_employees             => "1222",
       :profit_ratio                    => "7.48",
       :capacity_ratio                  => "1.4",
       :lots_and_sites                  => "162650.0",
       :solvency_ratio                  => "9.72",
       :accounting_date                 => Date.parse('2012-03-30'),
       :fixed_cost                      => "562808.0",
       :published_date                  => Date.parse('2012-03-30'),
       :year                            => "2011"
     }
  end

  subject { NNEClient::Finance.new(hash) }

  its(:accounting_date)                 { should == hash[:accounting_date] }
  its(:assets)                          { should == hash[:assets].to_f }
  its(:available_funds)                 { should == hash[:available_funds].to_f }
  its(:available_funds_ratio)           { should == hash[:available_funds_ratio].to_f }
  its(:balance)                         { should == hash[:balance].to_f }
  its(:capacity_ratio)                  { should == hash[:capacity_ratio].to_f }
  its(:contribution_ratio)              { should == hash[:contribution_ratio].to_f }
  its(:credit_rating)                   { should be_nil }
  its(:current_assets)                  { should == hash[:current_assets].to_f }
  its(:depreciations)                   { should == hash[:depreciations].to_f }
  its(:fixed_assets)                    { should == hash[:fixed_assets].to_f }
  its(:fixed_cost)                      { should == hash[:fixed_cost].to_f }
  its(:gross_profit)                    { should == hash[:gross_profit].to_f }
  its(:income_before_income_tax)        { should == hash[:income_before_income_tax].to_f }
  its(:link_pdf)                        { should == hash[:link_pdf] }
  its(:long_termed_liability)           { should == hash[:long_termed_liability].to_f }
  its(:lots_and_sites)                  { should == hash[:lots_and_sites].to_f }
  its(:net_outcome)                     { should == hash[:net_outcome].to_f }
  its(:number_of_employees)             { should == hash[:number_of_employees] }
  its(:placings)                        { should == hash[:placings].to_f }
  its(:profit)                          { should == hash[:profit].to_f }
  its(:profit_for_the_year)             { should == hash[:profit_for_the_year].to_f }
  its(:profit_ratio)                    { should == hash[:profit_ratio].to_f }
  its(:published_date)                  { should == hash[:published_date] }
  its(:return_on_assets)                { should == hash[:return_on_assets].to_f }
  its(:share_holders_funds_of_interest) { should == hash[:share_holders_funds_of_interest].to_f }
  its(:shareholders_funds)              { should == hash[:shareholders_funds].to_f }
  its(:short_termed_liability)          { should == hash[:short_termed_liability].to_f }
  its(:solvency_ratio)                  { should == hash[:solvency_ratio].to_f }
  its(:stock)                           { should == hash[:stock].to_f }
  its(:trade_debitors)                  { should == hash[:trade_debitors].to_f }
  its(:turnover)                        { should == hash[:turnover].to_f }
  its(:year)                            { should == hash[:year] }
end
