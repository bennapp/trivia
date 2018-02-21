#!/usr/bin/env ruby
require './parser.rb'
require './ocr.rb'

text = ocr('screenshot')
p parse(text) == { :question=>"Who co-hosted the ﬁrst season\nof American Idol with Ryan\nSeacrest in 2002?", :answers=>["Nick Cannon", "Carson Daly", "Brian Dunkelman"]}

text = ocr('ti-screenshot')
p parse(text) == {:question=>"In 1954, Texas Instruments\nhelped create the ﬁrst\ncommercial version of what?", :answers=>["Calculator", "Walkie-talkie", "Transistor radio"]}

text = ocr('the-wire')
p parse(text) == {:question=>"Season 3 of H805 “The Wire”\ncenters on which setting?", :answers=>["Newsroom", "Hamsterdam", "Docks"]}
