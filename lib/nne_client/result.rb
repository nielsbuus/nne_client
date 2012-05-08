module NNEClient
  class Result
    class << self
      # Basic attributes are attributes returned by NNE on the
      # CompanyBasic object
      def basic_attributes(*attrs)
        attrs.each do |attr|
          define_method(attr) { @result_hash[attr] }
        end
      end

      # Extended attributes are attributes returned by NNE on the
      # Company object
      def extended_attributes(*attrs)
        attrs.each do |attr|
          define_method(attr) { extended_attributes[attr] }
        end
      end
    end

    def initialize(result_hash)
      @result_hash = result_hash
    end

    basic_attributes :cvr_no, :p_no, :district, :phone, :street, :zip_code,
                     :official_name, :ad_protection

    extended_attributes :email, :homepage, :founded_year,
                        :number_of_employees, :tdf_name, :status_text

    def additional_names
      result = Fetch.new(tdc_id, 'fetchCompanyAdditionalNames').result_set.to_hash
      result[:array_ofstring][:item] || []
    end

    def trades
      trades = Fetch.new(tdc_id, 'fetchCompanyTrade').result_set.to_hash[:trade]
      if trades.kind_of?(Hash)
        [Trade.new(trades)]
      else
        trades.map{|trade| Trade.new(trade) }
      end
    end

    def ownerships
      ownerships = fetch_ownerships
      if ownerships.kind_of?(Hash)
        [Ownership.new(ownerships)]
      else
        ownerships.map{|ownership| Ownership.new(ownership) }
      end
    end

    def subsidiaries
      subsidiaries = fetch_subsidiaries
      if subsidiaries.kind_of?(Hash)
        [Subsidiary.new(subsidiaries)]
      else
        subsidiaries.map{|subsidiary| Subsidiary.new(subsidiary) }
      end
    end

    def finances
      finances = fetch_finances
      if finances.kind_of?(Hash)
        [Finance.new(finances)]
      else
        finances.map{|finance| Finance.new(finance) }
      end
    end

    private

    def fetch_finances
      Fetch.new(tdc_id, 'fetchCompanyFinance').result_set.to_hash[:finance] || []
    end

    def fetch_subsidiaries
      Fetch.new(tdc_id, 'fetchCompanySubsidiaries').result_set.to_hash[:subsidiary] || []
    end

    def fetch_ownerships
      Fetch.new(tdc_id, 'fetchCompanyOwnership').result_set.to_hash[:ownership] || []
    end

    def extended_attributes
      @extended_attributes ||= fetch_extended_attributes
    end

    def fetch_extended_attributes
      Fetch.new(tdc_id, 'fetchCompany').result_set.to_hash[:company]
    end

    def tdc_id
      @result_hash[:tdc_id]
    end
  end
end
