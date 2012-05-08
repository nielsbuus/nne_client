module NNEClient
  # @!visibility private
  class Question
    def initialize(query_hash, xml)
      @query_hash = query_hash
      @xml = xml
    end

    def render
      @xml.Question_1(question_attributes) do
        query(:houseNo, :string)
        query(:name, :string)
        query(:nameStartsWith, :boolean)
        query(:street, :string)
        query(:zipCode, :int)
        query(:tdcId, :int)
      end
    end

    private

    def query(attribute, type)
      if @query_hash[attribute]
        @xml.tag!(attribute, @query_hash[attribute], 'xsi:type' => "xsd:#{type}")
      end
    end

    def question_attributes
      {
        'xmlns:nne' => "http://com.stibo.net/nne/3.1/Types/NNE",
        'xsi:type' => "nne:Question"
      }
    end

  end
end
