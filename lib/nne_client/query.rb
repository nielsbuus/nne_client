module NNEClient
  class Query
    def initialize(query_hash, xml)
      @query_hash = query_hash
      @xml = xml
    end

    def render
      query(:houseNo, :string)
      query(:name, :string)
      query(:nameStartsWith, :boolean)
      query(:street, :string)
      query(:zipCode, :int)
    end

    def query(attribute, type)
      if @query_hash[attribute]
        @xml.tag!(attribute, @query_hash[attribute], 'xsi:type' => "xsd:#{type}")
      end
    end
  end
end
