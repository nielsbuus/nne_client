module NNEClient
  class Trade
    attr_reader :trade_code, :trade

    def initialize(trade_hash)
      @primary = trade_hash[:primary]
      @trade_code = trade_hash[:trade_code]
      @trade = trade_hash[:trade]
    end

    def primary?
      @primary
    end

    def ==(other)
      primary? == other.primary? &&
        trade_code == other.trade_code &&
        trade == other.trade
    end
  end
end
