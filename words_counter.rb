def word_counter(text)
	text = text.downcase.delete("^a-zA-Z '")
	words = text.split
	counter = Hash.new(0)
	words.each { |word|
		counter[word] += 1
	}
	counter = counter.sort_by { |word, number|
		number
	}
	counter.reverse!
	frequent_words = []
	return frequent_words if counter.length < 3
	i = 0
	counter.each { |word, number|
	if i < 3
		frequent_words << word
	 	i += 1
	end
	}
	return frequent_words
end

puts "Type the text below:"
text = gets.chomp
print word_counter(text)