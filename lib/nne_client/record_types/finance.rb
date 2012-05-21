module NNEClient
  class Finance
    extend NNEClient::ResultAttributes

    def initialize(finance_hash)
      @hash = finance_hash
    end

    attributes :accounting_date,
               :credit_rating,
               :link_pdf,
               :number_of_employees,
               :published_date,
               :year

    float_attributes :assets,
                     :available_funds,
                     :available_funds_ratio,
                     :balance,
                     :capacity_ratio,
                     :contribution_ratio,
                     :current_assets,
                     :depreciations,
                     :fixed_assets,
                     :fixed_cost,
                     :gross_profit,
                     :income_before_income_tax,
                     :long_termed_liability,
                     :lots_and_sites,
                     :net_outcome,
                     :placings,
                     :profit,
                     :profit_for_the_year,
                     :profit_ratio,
                     :return_on_assets,
                     :share_holders_funds_of_interest,
                     :shareholders_funds,
                     :short_termed_liability,
                     :solvency_ratio,
                     :stock,
                     :trade_debitors,
                     :turnover
  end
end
