module NNEClient
  # @!visibility private
  class Query
    def initialize(query_hash, xml)
      @query_hash = query_hash
      @xml = xml
    end

    def render
      Question.new(@query_hash, @xml).render
      tag(:int_2, hits_per_page, :int)
      tag(:int_3, wanted_page_number, :int)
      tag(:int_4, include_ad_protected, :int)
      tag(:String_5, NNEClient.config.access_key, :string)
    end

    private

    def include_ad_protected
      @query_hash[:include_ad_protected] ? 1 : 0
    end

    def hits_per_page
      @query_hash[:hits_per_page] || 10
    end

    def wanted_page_number
      @query_hash[:wanted_page_number] || 1
    end

    def tag(attribute, value, type)
      @xml.tag!(attribute, value, 'xsi:type' => "xsd:#{type}")
    end
  end
end
