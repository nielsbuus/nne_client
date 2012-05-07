module NNEClient
  class Search

    def initialize(query)
      @wsdl_url = 'http://service.nnerhverv.dk/nne-ws/3.1/NNE?WSDL'
      @query = query
    end

    def result_set
      query = @query
      result = client.request('wsdl', 'search', request_attributes) do
        soap.body do |xml|
          Query.new(query, xml).render
        end
      end
      ResultSet.new(result)
    end

    def client
      @client ||= Savon::Client.new(@wsdl_url)
    end

    def request_attributes
      { "env:encodingStyle" => "http://schemas.xmlsoap.org/soap/encoding/" }
    end
  end
end
