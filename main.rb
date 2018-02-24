#!/usr/bin/env ruby
require './parser.rb'
require './ocr.rb'
require './search.rb'
require './json_writer.rb'

def run(file_name)
  raw_text = ocr(file_name)
  parsed_text = parse(raw_text)
  search_results = search_and_parse_response(parsed_text)
  write_results_as_json(search_results)
end

initial_files = `ls /Users/ben/workspace/hq/screenshots`
loop do
  sleep 0.1
  files = `ls /Users/ben/workspace/hq/screenshots`

  if files != initial_files
    new_file = files.split("\n").last
    run(new_file)
  end
end

