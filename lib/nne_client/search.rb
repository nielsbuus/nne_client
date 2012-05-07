module NNEClient
  class Search
    attr_accessor :include_ad_protected

    def initialize(query)
      @wsdl_url = 'http://service.nnerhverv.dk/nne-ws/3.1/NNE?WSDL'
      @query = query
      @include_ad_protected = 0
    end

    def result_set
      search = self
      result = client.request('wsdl', 'search', request_attributes) do
        soap.body do |xml|
          search.question(xml)
          xml.int_2(search.hits_per_page, 'xsi:type' => "xsd:int")
          xml.int_3(search.wanted_page_number, 'xsi:type' => "xsd:int")
          xml.int_4(search.include_ad_protected, 'xsi:type' => "xsd:int")
          xml.String_5(nil, 'xsi:type' => "xsd:string")
        end
      end
      ResultSet.new(result)
    end

    def hits_per_page
      10
    end

    def wanted_page_number
      1
    end

    def question(xml)
      Question.new(@query, xml).render
    end

    def client
      @client ||= Savon::Client.new(@wsdl_url)
    end

    def request_attributes
      { "env:encodingStyle" => "http://schemas.xmlsoap.org/soap/encoding/" }
    end
  end
end
