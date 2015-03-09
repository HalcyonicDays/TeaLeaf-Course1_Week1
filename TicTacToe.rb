# Tic-Tac-Toe game instructions:
# Program presents a blank grid to the user after asking if user would like to play.
# Program asks for a first move which is assigned to the appropriate hash key if that key is empty.
# If the key is not empty, the computer asks for a different move to be made.
# A test is performed to see if victory has been achived and the grid is redrawn.
# ........ plans for an AI go here.  Otherwise, a move will be made to a random empty hash......
# A test is performed to see if victory has been achived and the grid is redrawn.
# Play continues so long as there is an empty hash value.  Once there are none, a tie is declared (since a victory would have been declared otherwise)

################## Initial Definitions portion ###########################
victory_states = [123, 456, 789, 147, 258, 369, 159, 357]
DESIGNATION = {User: "X", Comp: "O"}
moves_hash = {}
1.upto(9) {|key| moves_hash[key] = (key+64).chr}



top_row    = proc {puts "     |     |     "}
middle_row    = proc {|key| puts "  #{moves_hash[key]}  |  #{moves_hash[key+1]}  |  #{moves_hash[key+2]}  "}
bottom_row = proc {|key| puts "    #{key}|    #{key+1}|    #{key+2}"}
seperator_row   = proc {puts "-----+-----+-----"}

def draw_grid
  0.upto(2) do |i| 
    key = i*3+1
    top_row.call
    middle_row.(key)
    bottom_row.call(key)
    seperator_row.call unless key > 6 
  end
end


def victory_message(most_recent_move)
  possible_victories = victory_states.select {|elm| elm.to_s.include?(most_recent_move.to_s)}
  
  possible_victories.each do |elm|
    test_condition = elm.split
    test[0] == test[1] && test[0] == test[2] ? message = "#{moves_hash[most_recent_move]} wins! \n" : message ||= ""
  end
  message       # blank until there is a victory
end


def make_move(move, desig)
  moves_hash[move] = DESIGNATION[desig]
  p victory_message(move)
  draw_grid
end
##########################################################################