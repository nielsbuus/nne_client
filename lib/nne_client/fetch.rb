module NNEClient
  # @!visibility private
  class Fetch
    def initialize(tdc_id, command)
      @tdc_id = tdc_id
      @command = command
    end

    def result_set
      Request.execute(@command) do |xml|
        tag(xml, :int_1, @tdc_id, :int)
        tag(xml, :int_2, 0, :int)
        tag(xml, :String_3, nil, :string)
        tag(xml, :String_4, nil, :string)
      end
    end

    def tag(xml, attribute, value, type)
      xml.tag!(attribute, value, 'xsi:type' => "xsd:#{type}")
    end
  end
end
