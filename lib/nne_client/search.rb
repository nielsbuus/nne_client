module NNEClient
  class Search
    def initialize(query)
      @wsdl_url = 'http://service.nnerhverv.dk/nne-ws/3.1/NNE?WSDL'
      @query = query
    end

    def result_set
      search = self
      result = client.request('wsdl', 'search', request_attributes) do
        soap.body do |xml|
          xml.Question_1(question_attributes) do |xml|
            search.query(xml)
          end
          xml.int_2(10, 'xsi:type' => "xsd:int")
          xml.int_3(1, 'xsi:type' => "xsd:int")
          xml.int_4(0, 'xsi:type' => "xsd:int")
          xml.String_5(nil, 'xsi:type' => "xsd:string")
        end
      end
      ResultSet.new(result)
    end

    def query(xml)
      Query.new(@query, xml).render
    end

    def client
      @client ||= Savon::Client.new(@wsdl_url)
    end

    def question_attributes
      {
        'xmlns:nne' => "http://com.stibo.net/nne/3.1/Types/NNE",
        'xsi:type' => "nne:Question"
      }
    end

    def request_attributes
      { "env:encodingStyle" => "http://schemas.xmlsoap.org/soap/encoding/" }
    end
  end
end
