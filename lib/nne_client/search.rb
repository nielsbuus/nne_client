module NNEClient
  class Search

    def initialize(query)
      @query = query
    end

    def result_set
      NNEClient::Request.execute('search') do |xml|
        Query.new(@query, xml).render
      end
    end
  end
end
