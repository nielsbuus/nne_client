module NNEClient
  # @!visibility private
  class Search

    def initialize(query)
      @query = query
    end

    def result_set
      Request.execute('search') do |xml|
        Query.new(@query, xml).render
      end
    end
  end
end
