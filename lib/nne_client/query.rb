module NNEClient
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
      tag(:String_5, nil, :string)
    end

    private

    def include_ad_protected
      @query_hash[:includeAdProtected] ? 1 : 0
    end

    def hits_per_page
      @query_hash[:hitsPerPage] || 10
    end

    def wanted_page_number
      @query_hash[:wantedPageNumber] || 1
    end

    def tag(attribute, value, type)
      @xml.tag!(attribute, value, 'xsi:type' => "xsd:#{type}")
    end
  end
end
