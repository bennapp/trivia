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
  expectation = { :question=>"Who co-hosted the ﬁrst season of American Idol with Ryan Seacrest in 2002?", :answers=>["Nick Cannon", "Carson Daly", "Brian Dunkelman"]}
  test_output(actual, expectation)

  text = ocr('ti-screenshot')
  actual = parse(text)
  expectation = {:question=>"In 1954, Texas Instruments helped create the ﬁrst commercial version of what?", :answers=>["Calculator", "Walkie-talkie", "Transistor radio"]}
  test_output(actual, expectation)

  text = ocr('the-wire')
  actual = parse(text)
  expectation = {:question=>"Season 3 of H805 “The Wire” centers on which setting?", :answers=>["Newsroom", "Hamsterdam", "Docks"]}
  test_output(actual, expectation)
end

def run_search_tests

end

# run_ocr_and_parse_tests
# run_search_tests

