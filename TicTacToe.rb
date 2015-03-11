require 'pry'
# Tic-Tac-Toe game instructions:
# Program presents a blank grid to the user after asking if user would like to play.
# Program asks for a first move which is assigned to the appropriate hash key if that key is empty.
# If the key is not empty, the computer asks for a different move to be made.
# A test is performed to see if victory has been achived and the grid is redrawn.
# ........ plans for an AI go here.  Otherwise, a move will be made to a random empty hash......
# A test is performed to see if victory has been achived and the grid is redrawn.
# Play continues so long as there is an empty hash value.  Once there are none, a tie is declared (since a victory would have been declared otherwise)
# ∆(j) ø(o) §(6) (K) ◊(V)
################## Initial Definitions portion ###########################
DESIGNATION = {user: "X", comp: "ø"}
moves_hash = {}
1.upto(9) {|key| moves_hash[key] = " "}
#single_row_print = proc { |key| puts "     |     |     \n  #{moves_hash[key]}  |  #{moves_hash[key+1]}  |  #{moves_hash[key+2]}  \n    #{key}|    #{key+1}|    #{key+2}" }
#separator_row = proc {  }

def draw_grid(moves_hash)   # this displays a grid, but does not return anything or mutate an object.
  0.upto(2) do |i| 
    key = i*3+1
    puts "     |     |     \n  #{moves_hash[key]}  |  #{moves_hash[key+1]}  |  #{moves_hash[key+2]}  \n    #{key}|    #{key+1}|    #{key+2}"
    puts "-----+-----+-----" unless key > 6 
  end
  puts "\n"
end

def victory?(most_recent_move, moves_hash)
  victory_states ||= %w(123 456 789 147 258 369 159 357)
  possible_victories = victory_states.select {|elm| elm.include?(most_recent_move.to_s)}
  possible_victories.each do |elm|
    test_condition = elm.split("")
    return true if moves_hash[test_condition[0].to_i] == moves_hash[test_condition[1].to_i] && moves_hash[test_condition[0].to_i] == moves_hash[test_condition[2].to_i] #? message = "#{moves_hash[most_recent_move]} wins!" : message = ""
    #binding.pry
  end
  return false
end

def make_move(move, desig, moves_hash)       # this assigns the move to appropriate hash location, and checks if either player has won.
  available_moves = moves_hash.select { |key, val| val == " " }.keys
  if available_moves.include?(move)
    moves_hash[move] = DESIGNATION[desig]
    draw_grid(moves_hash)
  else
    puts "That is not an available space."
    draw_grid(moves_hash)
    users_move(moves_hash)
  end
  if victory?(move, moves_hash)
end

def easy_ai_move(moves_hash)       # This AI makes moves at random from a list of available spaces.
  available_moves = moves_hash.select { |key, val| val == " " }.keys
  puts "This game is a draw." if available_moves == []
  make_move(available_moves.sample, :comp, moves_hash) unless available_moves == []
end

def users_move(moves_hash, warning = "")
  puts warning unless warning == ""
  p "Please select where you would like you play... \n Enter integer values for best results (1-9): "
  location = gets.chomp.to_i
  (1..9) === location ? make_move(location, :user, moves_hash) : users_move(moves_hash, "Invalid entry.")
end
  
def moves_remain?(moves_hash)
  available_moves = moves_hash.select { |key, val| val == " " }.keys
  return !(available_moves == [])
end

##########################################################################



puts "Would you like to play Tic-Tac-Toe? (Y / N)"
answer = gets.chomp.downcase

while answer[0] == "y" do  
  draw_grid(moves_hash)
  while moves_remain?(moves_hash)
    users_move(moves_hash)
    easy_ai_move(moves_hash)
  end
  puts "Would you like to play again? (Y / N)"
  answer = gets.chomp.downcase
  1.upto(9) {|key| moves_hash[key] = " "}
end





