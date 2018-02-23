#!/usr/bin/env ruby
require './parser.rb'
require './ocr.rb'
require './search.rb'

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

def test_stubbed_results
  answers_and_question = {
    question: "In 1954, Texas Instruments helped create the ﬁrst commercial version of what?",
    answers: ["Calculator", "Walkie-talkie", "Transistor radio"]
  }

  results = answers_and_question[:answers].map do |answer|
    result = nil
    File.open("search-#{answer}.txt","rb") { |f| result = Marshal.load(f) }
    result
  end

  scores = []
  answers_and_question[:answers].each_with_index do |answer, i|
    scores << search_for(answers_and_question[:question], answer, results[i])
  end

  expected_scores = [
    {:answer=>"Calculator", :result=>"38800"}, # Note this is the wrong answer, need to fix score
    {:answer=>"Walkie-talkie", :result=>"120"},
    {:answer=>"Transistor radio", :result=>"1030"}
  ]
  test_output(scores, expected_scores)
end

run_ocr_and_parse_tests
test_stubbed_results
