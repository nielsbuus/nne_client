module NNEClient
  class Result
    def initialize(result_hash)
      @result_hash = result_hash
    end

    def official_name
      @result_hash[:official_name]
    end

    def additional_names
      result = Fetch.new(tdc_id, 'fetchCompanyAdditionalNames').result_set.to_hash
      result[:array_ofstring][:item]
    end

    private

    def tdc_id
      @result_hash[:tdc_id]
    end
  end
end
