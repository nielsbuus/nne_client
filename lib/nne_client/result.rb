module NNEClient

  # The Result is used to represent a single result from a result set. It can
  # be seen roughly as an NNE CompanyBasic object. It provides transparent
  # loading of attributes from the NNE Company object. It also provides methods
  # for navigating the API further.
  #
  # The Result can be instantiated with either a full result hash from an API
  # query or with just a tdc_id in which case the attributes will be lazy loaded
  # from the API.
  class Result
    class << self
      # Basic attributes are attributes returned by NNE on the
      # CompanyBasic object
      #
      # @!visibility private
      def basic_attributes(*attrs)
        attrs.each do |attr|
          define_method(attr) { basic_attribute(attr) }
        end
      end

      # Extended attributes are attributes returned by NNE on the
      # Company object
      #
      # @!visibility private
      def extended_attributes(*attrs)
        attrs.each do |attr|
          define_method(attr) { extended_attributes[attr] }
        end
      end
    end

    # @!visibility private
    attr_reader :tdc_id

    # @!visibility private
    def initialize(result_hash)
      @basic_attributes = result_hash
      @tdc_id = result_hash[:tdc_id]
    end

    # @!attribute [r] cvr_no
    # @!attribute [r] p_no
    # @!attribute [r] district
    # @!attribute [r] phone
    # @!attribute [r] street
    # @!attribute [r] zip_code
    # @!attribute [r] official_name
    # @!attribute [r] ad_protection
    basic_attributes :cvr_no, :p_no, :district, :phone, :street, :zip_code,
                     :official_name, :ad_protection

    # @!attribute [r] email
    # @!attribute [r] homepage
    # @!attribute [r] founded_year
    # @!attribute [r] number_of_employees
    # @!attribute [r] tdf_name
    # @!attribute [r] status_text
    extended_attributes :email, :homepage, :founded_year,
                        :number_of_employees, :tdf_name, :status_text

    # List of additional_names
    def additional_names
      result = Fetch.new(tdc_id, 'fetchCompanyAdditionalNames').result_set.to_hash
      result[:array_ofstring][:item] || []
    end

    # List of trades
    def trades
      trades = Fetch.new(tdc_id, 'fetchCompanyTrade').result_set.to_hash[:trade]
      if trades.kind_of?(Hash)
        [Trade.new(trades)]
      else
        trades.map{|trade| Trade.new(trade) }
      end
    end

    # List of associates
    def associates
      subsidiaries = fetch_associates
      if subsidiaries.kind_of?(Hash)
        [Subsidiary.new(subsidiaries)]
      else
        subsidiaries.map{|subsidiary| Subsidiary.new(subsidiary) }
      end
    end

    # List of ownerships
    def ownerships
      ownerships = fetch_ownerships
      if ownerships.kind_of?(Hash)
        [Ownership.new(ownerships)]
      else
        ownerships.map{|ownership| Ownership.new(ownership) }
      end
    end

    # List of subsidiaries
    def subsidiaries
      subsidiaries = fetch_subsidiaries
      if subsidiaries.kind_of?(Hash)
        [Subsidiary.new(subsidiaries)]
      else
        subsidiaries.map{|subsidiary| Subsidiary.new(subsidiary) }
      end
    end

    # List of finance records
    def finances
      finances = fetch_finances
      if finances.kind_of?(Hash)
        [Finance.new(finances)]
      else
        finances.map{|finance| Finance.new(finance) }
      end
    end

    def ==(other)
      other.tdc_id == tdc_id
    end

    private

    def fetch_associates
      Fetch.new(tdc_id, 'fetchCompanyAssociates').result_set.to_hash[:subsidiary] || []
    end

    def fetch_finances
      Fetch.new(tdc_id, 'fetchCompanyFinance').result_set.to_hash[:finance] || []
    end

    def fetch_subsidiaries
      Fetch.new(tdc_id, 'fetchCompanySubsidiaries').result_set.to_hash[:subsidiary] || []
    end

    def fetch_ownerships
      Fetch.new(tdc_id, 'fetchCompanyOwnership').result_set.to_hash[:ownership] || []
    end

    def basic_attribute(attribute)
      unless @basic_attributes.has_key?(attribute)
        unless @basic_result
          @basic_result = Search.new(:tdcId => tdc_id).result_set.first
        end
        @basic_attributes[attribute] = @basic_result.send(attribute)
      end
      @basic_attributes[attribute]
    end

    def extended_attributes
      @extended_attributes ||= fetch_extended_attributes
    end

    def fetch_extended_attributes
      Fetch.new(tdc_id, 'fetchCompany').result_set.to_hash[:company]
    end
  end
end
