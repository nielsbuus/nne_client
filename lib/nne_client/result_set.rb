module NNEClient
  # A ResultSet holds the results returned by the SOAP API. The ResultSet includes Enumerable
  # so it is possible to use all the regular enumerable methods to iterate over it.
  class ResultSet
    include Enumerable

    def initialize(result)
      @result = result
    end

    # Yield each result in turn
    def each
      company_basic.each do |cb|
        yield Result.new(cb)
      end
    end

    # The to_hash method is used by other parts of the library and can't be
    # made private for now.
    # @!visibility private
    def to_hash
      @result.to_hash
    end

    private

    def company_basic
      if to_hash[:company_basic].kind_of?(Hash)
        [to_hash[:company_basic]]
      else
        to_hash[:company_basic]
      end
    end
  end
end
