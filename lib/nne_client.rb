require 'savon'
require "nne_client/version"

module NNEClient
  class NNE2
    def initialize
      wsdl_url = 'http://service.nnerhverv.dk/nne-ws/3.1/NNE?WSDL'
      @client = Savon::Client.new(wsdl_url)
    end

    def search_by_name(name)
      response = @client.request('wsdl', 'search', "env:encodingStyle" => "http://schemas.xmlsoap.org/soap/encoding/") do
        soap.body do |xml|
          xml.Question_1('xmlns:nne' => "http://com.stibo.net/nne/3.1/Types/NNE", 'xsi:type' => "nne:Question") do
            xml.name(name, 'xsi:type' => "xsd:string")
          end

          xml.int_2(10, 'xsi:type' => "xsd:int")
          xml.int_3(1, 'xsi:type' => "xsd:int")
          xml.int_4(0, 'xsi:type' => "xsd:int")
          xml.String_5(nil, 'xsi:type' => "xsd:string")
        end
      end
    end
  end
end
