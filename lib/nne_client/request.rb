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
      ResultSet.new(perform_request(&block))
    end

    private

    def perform_request(&block)
      str = StringIO.new
      builder = Builder::XmlMarkup.new(:target => str)
      yield builder
      str.rewind
      client.call(@command.to_sym, message: str.read, attributes: request_attributes)
    end

    def request_attributes
      { :'env:encodingStyle' => "http://schemas.xmlsoap.org/soap/encoding/" }
    end

    def client
      @client ||= Savon.client do |client|
        client.wsdl         File.expand_path("../../../wsdl/nne.wsdl", __FILE__)
        client.read_timeout NNEClient.config.http_read_timeout
        client.log          !!NNEClient.config.log
        client.log_level    NNEClient.config.log_level
        client.logger       NNEClient.config.logger if NNEClient.config.logger
      end
      @client
    end
  end
end
