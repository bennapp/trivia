#!/usr/bin/env ruby
require './parser.rb'
require './ocr.rb'
require './search.rb'
require './json_writer.rb'

def test_output(actual, expectation)
  result = actual == expectation
  if result
    p true
  else
    p 'failed'
    p "actual: #{actual}"
    p "expectation: #{expectation}"
  end
end

def run_ocr_and_parse_tests
  text = ocr('screenshot')
  actual = parse(text)
  expectation = {
    question: "Who co-hosted the ﬁrst season of American Idol with Ryan Seacrest in 2002?",
    answers: ["Nick Cannon", "Carson Daly", "Brian Dunkelman"]
  }
  test_output(actual, expectation)

  text = ocr('ti-screenshot')
  actual = parse(text)
  expectation = {
    question: "In 1954, Texas Instruments helped create the ﬁrst commercial version of what?",
    answers: ["Calculator", "Walkie-talkie", "Transistor radio"]
  }
  test_output(actual, expectation)

  text = ocr('the-wire')
  actual = parse(text)
  expectation = {
    question: "Season 3 of H805 “The Wire” centers on which setting?",
    answers: ["Newsroom", "Hamsterdam", "Docks"]
  }
  test_output(actual, expectation)
end

def serialize_search_result
  answers_and_question = {
    question: "In 1954, Texas Instruments helped create the ﬁrst commercial version of what?",
    answers: ["Calculator", "Walkie-talkie", "Transistor radio"]
  }

  answers_and_question[:answers].each do |answer|
    result = GoogleCustomSearchApi.search("#{answers_and_question[:question]} #{answer}")

    File.open("search-#{answer}.txt", "wb") do |file|
      Marshal.dump(result, file)
    end
  end
end

def test_stubbed_search_results
  answers_and_question = {
    question: "In 1954, Texas Instruments helped create the ﬁrst commercial version of what?",
    answers: ["Calculator", "Walkie-talkie", "Transistor radio"]
  }

  cached_results = answers_and_question[:answers].map do |answer|
    cached_result = nil
    File.open("search-#{answer}.txt","rb") { |f| cached_result = Marshal.load(f) }
    cached_result
  end

  results = []
  answers_and_question[:answers].each_with_index do |answer, i|
    results << search_for(answers_and_question[:question], answer, cached_results[i])
  end

  expected_results = [
    {:answer=>"Calculator", :count=>"38800"},
    {:answer=>"Walkie-talkie", :count=>"120"},
    {:answer=>"Transistor radio", :count=>"1030"}
  ]

  results_without_items = results.map { |result| { answer: result[:answer], count: result[:count] } }

  test_output(results_without_items, expected_results)
  results
end


###TESTS

# OCR and PARSE
# run_ocr_and_parse_tests

# SEARCH w/ stubbed results
results_with_items = test_stubbed_search_results

# JSON WRITER
write_results_as_json(results_with_items)
