require 'rubygems'
require 'vcr'
require 'equivalent-xml'
require 'nne_client'

HTTPI.log = false



VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr_cassettes'
  c.hook_into :fakeweb
  c.register_request_matcher :soap_body_matcher do |request_1, request_2|
    node_1 = Nokogiri::XML(request_1.body)
    node_2 = Nokogiri::XML(request_2.body)
    EquivalentXml.equivalent?(node_1, node_2, opts = { :element_order => true, :normalize_whitespace => false })
  end
end

def soap_vcr(cassette_name)
  VCR.use_cassette(cassette_name, :match_requests_on => [:soap_body_matcher]) do
    yield
  end
end
