def parse(text)
  elements = text.split("\n\n")
  question = elements.first.gsub(/\n/, ' ')
  answers = elements[1..-1].map { |el| el.split("\n") }.flatten

  {
    question: question,
    answers: answers
  }
end
