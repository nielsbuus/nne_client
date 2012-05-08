module NNEClient
  class Subsidiary
    extend NNEClient::ResultAttributes

    attributes :name, :country

    def initialize(subsidiary_hash)
      @hash = subsidiary_hash
    end

    def ==(other)
      share == other.share &&
        name == other.name &&
        country == other.country
    end

    def share
      @hash[:share].strip
    end

    def company
      Search.new(:tdcId => @hash[:tdc_id]).result_set.first
    end
  end
end
