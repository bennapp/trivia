# https://github.com/wiseleyb/google_custom_search_api
require 'google_custom_search_api'
require 'pry'

GOOGLE_API_KEY = ENV['GOOGLE_API_KEY']
GOOGLE_SEARCH_CX = ENV['GOOGLE_SEARCH_CX']

def search_for(question, answer, stubbed_result = nil)
  if stubbed_result
    result = stubbed_result
  else
    result = GoogleCustomSearchApi.search("#{question} #{answer}")
  end

  {
    answer: answer,
    result: score(result)
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
