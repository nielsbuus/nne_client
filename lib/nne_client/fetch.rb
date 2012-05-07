module NNEClient
  class Fetch
    def initialize(tdc_id, command)
      @tdc_id = tdc_id
      @command = command
    end

    def result_set
      Request.execute(@command) do |xml|
        tag(xml, :int_1, @tdc_id, :int)
      end
    end

    def tag(xml, attribute, value, type)
      xml.tag!(attribute, value, 'xsi:type' => "xsd:#{type}")
    end
  end
end
