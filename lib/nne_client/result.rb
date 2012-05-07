module NNEClient
  class Result
    def initialize(result_hash)
      @result_hash = result_hash
    end

    def company_name
      @result_hash[:official_name]
    end
  end
end
