module NNEClient
  class ResultSet
    include Enumerable

    def initialize(result)
      @result = result
    end

    def each
      company_basic.each do |cb|
        yield Result.new(cb)
      end
    end

    def company_basic
      if to_hash[:company_basic].kind_of?(Hash)
        [to_hash[:company_basic]]
      else
        to_hash[:company_basic]
      end
    end

    def to_hash
      @result.to_hash
    end
  end
end
