#!/usr/bin/env ruby
require './parser.rb'
require './ocr.rb'

text = ocr('screenshot')
p parse(text) == { :question=>"Who co-hosted the ﬁrst season\nof American Idol with Ryan\nSeacrest in 2002?", :answers=>["Nick Cannon", "Carson Daly", "Brian Dunkelman"]}
