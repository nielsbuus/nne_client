module NNEClient
  class Ownership
    attr_reader :share, :name, :country

    def initialize(ownership_hash)
      @share = ownership_hash[:share].strip
      @name = ownership_hash[:name]
      @country = ownership_hash[:country] unless ownership_hash[:country].kind_of?(Hash)
    end

    def ==(other)
      share == other.share &&
        name == other.name &&
        country == other.country
    end
  end
end
