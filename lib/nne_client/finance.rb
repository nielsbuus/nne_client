module NNEClient
  class Finance
    class << self
      def attributes(*attrs)
        attrs.each do |attribute|
          define_method(attribute) do
            @hash[attribute] unless @hash[attribute].kind_of?(Hash)
          end
        end
      end
    end

    def initialize(finance_hash)
      @hash = finance_hash
    end

    attributes :accounting_date,
               :assets,
               :available_funds,
               :available_funds_ratio,
               :balance,
               :capacity_ratio,
               :contribution_ratio,
               :credit_rating,
               :current_assets,
               :depreciations,
               :fixed_assets,
               :fixed_cost,
               :gross_profit,
               :income_before_income_tax,
               :link_pdf,
               :long_termed_liability,
               :lots_and_sites,
               :net_outcome,
               :number_of_employees,
               :placings,
               :profit,
               :profit_for_the_year,
               :profit_ratio,
               :published_date,
               :return_on_assets,
               :share_holders_funds_of_interest,
               :shareholders_funds,
               :short_termed_liability,
               :solvency_ratio,
               :stock,
               :trade_debitors,
               :turnover,
               :year
  end
end
