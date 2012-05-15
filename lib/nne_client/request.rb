module NNEClient
  # @!visibility private
  class Request
    class << self
      def execute(command, &block)
        new(command).result_set(&block)
      end
    end

    def initialize(command)
      @command = command
    end

    def result_set(&block)
      retries = 3
      begin
        ResultSet.new(perform_request(&block))
      rescue Net::HTTPRequestTimeOut => e
        retries -= 1
        retry if retries > 0
      end
    end

    private

    def perform_request(&block)
      client.request('wsdl', @command, request_attributes) do
        str = StringIO.new
        builder = Builder::XmlMarkup.new(:target => str)
        yield builder
        str.rewind
        soap.body = str.read
      end
    end

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
