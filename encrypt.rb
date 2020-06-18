def encrypt(string, n)
	if string == nil or string == "" or n < 1
		return string
	end
	string.downcase!
	n.times {
		array = string.split('')
		i = 0
		even = []
		odd = []
		array.each do |x|
			i += 1
			if i % 2 == 0
				even << x
			else odd << x
			end
		end
		array = even + odd
		string = array.join("")
	}
	return string
end

def decrypt(string, n)
	length = string.length / 2
	if string == nil or string == "" or n < 1 or length < 1
		return string
	end
	array = string.split('')
	n.times {
		array = array.each_slice(length).to_a
		odd = array[0]
		if array[2] != nil
			even = array[1] + array[2]
		else even = array[1]
		end
		i = 0
		array = []
		while (i < even.length)
			array << even[i]
			array << odd[i]
			i += 1
		end
		string = array.join("")
	}
	return string
end

text = "A Whole Wolfpack in a Bunch of Backpacks"
puts encrypt(text, 6)
text = "bo oacc  neffk s hhwbaanaulolckkawc  ppi"
puts decrypt(text, 6)