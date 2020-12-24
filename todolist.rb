class Lists
	attr_accessor :array, :list
	def initialize
		@array = []
		@hashes = []
		@list = nil
	end

	def new_list(name, hash)
		@array << name
		@hashes << hash
	end

	def delete_list(index)
		@array.delete_at(index)
		@hashes.delete_at(index)
	end

	def show_lists
		i = 0
		@array.each do |x|
			i += 1
			puts "#{i}) #{x}"
		end
	end

	def show_notes(index)
		@list = @hashes[index]
		if @list == {}
			puts "The list is empty."
		else
			puts "#{@array[index]}:"
			puts ""
			note_num = 0
			@list.each do |x, y|
				note_num += 1
				puts "#{note_num}) #{x} #{y}"
			end
		end
	end

	def add_note(note)
		@list[note] = "☐"
	end

	def delete_note(number)
		i = 0
		key_to_delete = nil
		@list.each do |x, y|
			i += 1
			key_to_delete = x if i == number
		end
		@list.delete(key_to_delete)
	end

	def check_note(number)
		i = 0
		note_to_change = nil
		@list.each do |x, y|
			i += 1
			note_to_change = x if i == number
		end
		if @list[note_to_change] == "☐"
			@list[note_to_change] = "✓"
		else
			@list[note_to_change] = "☐"
		end
	end

	def generate_dump
		dump = ""
		i = 0
		@array.each do |x|
			dump += "#{x}:"
			dump += "\n"
			@hashes[i].each do |x, y|
				dump += "   #{x} #{y}\n"
			end
			i += 1
		end
		return dump
	end
end


class Menu

	public

	def initialize
		@array = Lists.new
		menu_line
		puts "Hello! I'm a 'to do list' program."
	end

	def show_main
		while @input != 5
			puts "What do you want to do?"
			puts " "
			puts "1 - Open list / 2 - Add list / 3 - Delete list / 4 - Export / 5 - Exit"
			puts "Type a number below:"
			get_input
		end
	end

	private

	def menu_line
		puts " "
		20.times {print "☆ "}
		puts " "
		puts " "
	end

	def get_input
		@input = gets.to_i
		case @input
		when 1
			open_list
		when 2
			add_new_list
		when 3
			delete_list
		when 4
			export_lists
		when 5
			exit_program
		end
	end

	def show_lists
		menu_line
		if @array.array == []
			puts "You don't have any lists yet."
		else
			puts "You now have the following lists:"
			@array.show_lists
		end
		menu_line
	end

	def add_new_list
		puts "Type the name of a new list below:"
		name = gets.chomp
		menu_line
		if name == nil or name == ""
			puts "The name cannot be empty."
		elsif @array.array.include?(name)
			puts "The list with such name already exists."
		else
			@array.new_list(name, Hash.new)
			puts "New list added successfully."
		end
		menu_line
		return
	end

	def delete_list
		show_lists
		if @array.array != []
			puts "Enter the number of the list that you want to delete:"
			number = gets.chomp.to_i - 1
			menu_line
			if @array.array.length < number or number < 0
				puts "Wrong number."
			else
				@array.delete_list(number)
				puts "The list deleted successfully."
			end
			menu_line
		end
	end

	def open_list
		show_lists
		if @array.array != []
			puts "Enter the number of the list that you want to open:"
			@list_number = gets.chomp.to_i - 1
			menu_line
			if @array.array.length < @list_number or @list_number < 0
				puts "Wrong number."
			else
				@array.show_notes(@list_number)
			end
			menu_line
			list_menu
		end
	end

	def list_menu
		while @input != 5
			puts "What do you want to do?"
			puts " "
			puts "1 - Add note / 2 - Delete note / 3 - Check/Uncheck note / 4 - Main menu / 5 - Exit"
			puts "Type a number below:"
			get_list_menu_input
		end
	end

	def get_list_menu_input
		@input = gets.to_i
		case @input
		when 1
			add_note
		when 2
			delete_note
		when 3
			check_note
		when 4
			show_lists
			show_main
		when 5
			exit_program
			show_main
		end
	end

	def add_note
		menu_line
		puts "Type a new note below:"
		new_note = gets.chomp
		menu_line
		if new_note == ""
			"You didn't type anything."
		else
			@array.add_note(new_note)
			puts "New note added successfully."
		end
		menu_line
		@array.show_notes(@list_number)
		menu_line
	end

	def delete_note
		menu_line
		@array.show_notes(@list_number)
		menu_line
		if @array.list != {}
			puts "Enter the number of the note that you want to delete:"
			note_num = gets.to_i
			if note_num == nil or @array.list.length < note_num or note_num < 0
				puts "Wrong number."
			else
				@array.delete_note(note_num)
				puts "The note deleted successfully."
			end
			menu_line
			@array.show_notes(@list_number)
			menu_line
		end
	end

	def check_note
		menu_line
		@array.show_notes(@list_number)
		menu_line
		if @array.list != {}
			puts "Enter the number of the note that you want to check/uncheck:"
			note_num = gets.to_i
			if note_num == nil or @array.list.length < note_num or note_num < 0
				puts "Wrong number."
			else
				@array.check_note(note_num)
				puts "Done."
				menu_line
				@array.show_notes(@list_number)
				menu_line
			end
		end
	end

	def export_lists
		menu_line
		if @array.array == []
			puts "You don't have any lists yet."
		else
			filename = "lists_dump.txt"
			filenum = 0
			while File.exists?(filename)
				filenum += 1
				filename = "lists_dump" + filenum.to_s + ".txt"
			end
			file = File.new(filename, "w")
			dump = @array.generate_dump
			File.write(filename, dump)
			puts "Dump created successfully at #{Dir.pwd}."
		end
		menu_line
	end

	def exit_program
		puts "Bye!"
	end

end

Menu.new.show_main