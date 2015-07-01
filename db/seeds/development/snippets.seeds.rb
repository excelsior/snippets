25.times do
  Snippet.create!(body: Populator.sentences(3..15))
end
