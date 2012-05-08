module NNEClient
  # @!visibility private
  class Request
    class << self
      def execute(command, &block)
        new(command, &block).result_set
      end
    end

    def initialize(command, &block)
      @result = client.request('wsdl', command, request_attributes) do
        soap.body do |xml|
          yield xml
        end
      end
    end

    def result_set
      ResultSet.new(@result)
    end

    private

    def request_attributes
      { "env:encodingStyle" => "http://schemas.xmlsoap.org/soap/encoding/" }
    end

    def wsdl_url
      'http://service.nnerhverv.dk/nne-ws/3.1/NNE?WSDL'
    end

    def client
      @client ||= Savon::Client.new(wsdl_url)
    end
  end
end
