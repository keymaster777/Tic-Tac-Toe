class Game
	def initialize
		@board=Board.new
		start
		@board.show_board
		play
	end

	def start
		puts "-----------------------"
    	puts "     Tic-Tac-Toe"
		puts "-----------------------"
		puts "  Enter 0 to exit or   "
		puts " enter 1-9 to play on  "
		puts "     that square."
		puts "-----------------------"
	end


	def play
		loops=0
		@filled = []
		@hash_board={}
		#Intentional endless loop, only an input of '0' or the game ending will terminate the loop
		while true
			end_conditions #Checks if theres a winner, if not then game continues

			#This block of code ensures that the users input is valid
			print "Enter Command Number: "
			num = gets.chomp
			check = invalid_entries(num)
			while (!check)
				print "Invalid Entry [#{num}] Re-try: "
				num=gets.chomp
				check = invalid_entries(num)
			end
			num=num.to_i

			if num==0
				exit
			else
				if loops%2==0
					@board.altar_board("X",num-1)
					@hash_board[num]="X"
				else
					@board.altar_board("O",num-1)
					@hash_board[num]="O"
				end
			end
			@board.show_board
			@filled << num.to_i
			loops+=1
		end
	end

	def invalid_entries num
		return false if num.to_i.to_s != num
		return false if num.to_i>9 || num.to_i<0
		return false if @filled.include?(num.to_i)
		return true
	end

	def combos_check array, val
		win_bool=true
		array.each do |var|
			if @hash_board[var]!=val
				win_bool=false
			end
		end
		if win_bool
		puts "#{val} Wins!"
		exit
		end
	end
	
	def end_conditions 
		win_combos=[[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
		8.times do |var|
			combos_check(win_combos[var],"X")
			combos_check(win_combos[var],"O")
		end

		if @filled.length==@board.array.length
			puts "It's a Tie!"
			exit
		end
	end 

	class Board
		attr_reader :array
		def initialize
			@array=["1","2","3","4","5","6","7","8","9"]
		end

		def show_board
			puts ""
			@array.each_with_index do |value,index|
				if index%3==2
					puts " " + value + " "
					puts "     ---+---+---" if index<8
				else
					print "     " if index==0||index==3||index==6
					print " " + value + " |"
				end
			end
			puts ""
		end

		def altar_board(value, index)
			@array[index]=value
		end
	end
end

my_game=Game.new