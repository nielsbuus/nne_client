module NNEClient
  class Subsidiary
    attr_reader :share, :name, :country

    def initialize(subsidiary_hash)
      @share = subsidiary_hash[:share].strip
      @name = subsidiary_hash[:name]
      @country = subsidiary_hash[:country] unless subsidiary_hash[:country].kind_of?(Hash)
    end

    def ==(other)
      share == other.share &&
        name == other.name &&
        country == other.country
    end
  end
end
