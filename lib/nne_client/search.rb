module NNEClient
  class Search
    def initialize(name)
      @wsdl_url = 'http://service.nnerhverv.dk/nne-ws/3.1/NNE?WSDL'
      @name = name
    end

    def result
      name = @name
      result = client.request('wsdl', 'search',
                              "env:encodingStyle" => "http://schemas.xmlsoap.org/soap/encoding/") do
        soap.body do |xml|
          xml.Question_1('xmlns:nne' => "http://com.stibo.net/nne/3.1/Types/NNE",
                         'xsi:type' => "nne:Question") do
            xml.name(name, 'xsi:type' => "xsd:string")
          end

          xml.int_2(10, 'xsi:type' => "xsd:int")
          xml.int_3(1, 'xsi:type' => "xsd:int")
          xml.int_4(0, 'xsi:type' => "xsd:int")
          xml.String_5(nil, 'xsi:type' => "xsd:string")
        end
      end
      result.to_hash
    end

    def client
      @client ||= Savon::Client.new(@wsdl_url)
    end
  end
end
