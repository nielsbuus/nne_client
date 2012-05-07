module NNEClient
  class Search
    def initialize(name)
      @wsdl_url = 'http://service.nnerhverv.dk/nne-ws/3.1/NNE?WSDL'
      @name = name
    end

    def result_set
      name = @name
      result = client.request('wsdl', 'search', request_attributes) do
        soap.body do |xml|
          xml.Question_1(question_attributes) do
            xml.name(name, 'xsi:type' => "xsd:string")
          end
          xml.int_2(10, 'xsi:type' => "xsd:int")
          xml.int_3(1, 'xsi:type' => "xsd:int")
          xml.int_4(0, 'xsi:type' => "xsd:int")
          xml.String_5(nil, 'xsi:type' => "xsd:string")
        end
      end
      ResultSet.new(result)
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
