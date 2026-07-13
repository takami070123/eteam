words = %w[
  apple
  banana
  cat
  dog
  elephant
  fish
  game
  hello
  ruby
  rails
]

words.each do |w|
  Word.create!(word: w)
end
