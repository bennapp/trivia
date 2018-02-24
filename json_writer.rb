def write_results_as_json(results)
  json = results.to_json
  File.open("json-dump.js", "wb") do |file|
    file.write("module.exports = #{json}")
  end
end
