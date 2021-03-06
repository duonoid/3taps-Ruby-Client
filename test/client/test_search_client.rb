require 'helper' 

class TestSearchClient < Test::Unit::TestCase
  should "get the range request result" do
    range_request = RangeRequest.new
    search_request = SearchRequest.new
    search_request.category = 'VAUT'
    search_request.annotations = {:Make => "porsche"}
    range_request.search_request = search_request
    range_request.fields = ['price', 'year']
    client = SearchClient.new
    range_response = client.range(range_request)
    assert_equal RangeResponse, range_response.class
    assert_equal range_request.fields, range_response.ranges.collect{|r| r['field']}
  end

  should "get the search request result" do
    search_request = SearchRequest.new
    search_request.category = 'VAUT'
    search_request.rpp = 2
    search_request.annotations = {:Make => "porsche"}
    client = SearchClient.new
    search_response = client.search(search_request)
    assert_equal SearchResponse, search_response.class
    assert_equal Array, search_response.results.class
    assert_equal Hash, search_response.results.first.class
  end

  should "get the count request result" do
    search_request = SearchRequest.new
    search_request.category = 'VAUT'
    search_request.annotations = {:Make => "porsche"}
    client = SearchClient.new
    count_response = client.count(search_request)
    assert_equal CountResponse, count_response.class
    assert_not_equal nil , count_response.count

  end

  should "get the summary result" do
    search_request = SearchRequest.new
    search_request.category = 'VAUT'
    search_request.annotations = {:Make => "porsche"}
    client = SearchClient.new
    summary_response = client.summary(search_request)
    assert_equal SummaryResponse, summary_response.class
  end

  should "get the best match result" do
    search_keywords = "iPad Apple iPhone"
    client = SearchClient.new
    best_match_response = client.best_match(CGI.escape search_keywords)
    assert_equal BestMatchResponse, best_match_response.class
    assert_equal 'SELE', best_match_response.category
  end
end