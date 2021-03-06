module NNEClient
  class Ownership
    extend NNEClient::ResultAttributes

    attributes :name, :country

    def initialize(ownership_hash)
      @hash = ownership_hash
    end

    def share
      @hash[:share].strip
    end

    def ==(other)
      share == other.share &&
        name == other.name &&
        country == other.country
    end

    def company
      Result.new(:tdc_id => @hash[:tdc_id])
    end
  end
end
