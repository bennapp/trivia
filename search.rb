# https://github.com/wiseleyb/google_custom_search_api
require 'google_custom_search_api'
require 'pry'

GOOGLE_API_KEY = ENV['GOOGLE_API_KEY']
GOOGLE_SEARCH_CX = ENV['GOOGLE_SEARCH_CX']

def search_for(question, answer, stubbed_result = nil)
  if stubbed_result
    result = stubbed_result
  else
    result = GoogleCustomSearchApi.search(query(question, answer))
  end

  {
    answer: answer,
    count: score(result),
    items: result['items'].first(3).map { |item| "#{item['htmlTitle']} \n\n #{item['htmlSnippet']}" }
  }
end

def search_and_parse_response(question_and_answers)
  question = question_and_answers[:question]
  answers = question_and_answers[:answers]

  answers.map { |answer| search_for(question, answer) }
end

# Not a very good score
def score(result)
  result['searchInformation']['totalResults']
end

# http://www.googleguide.com/interpreting_queries.html
# Google gives more priority to pages that have search terms in the same order as the query.
# http://musingsaboutlibrarianship.blogspot.com/2015/10/6-common-misconceptions-when-doing.html
def query(question, answer)
  "(#{answer}) AROUND(9) (#{question})"
end
