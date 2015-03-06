# This calculator will handle addition, subtraction, multiplication, and division (with and without remainders)
# Furthermore, it can raise a number to an exponent.  There will be an accuracy out to 4 decimal places.
# Acceptable input will be numeric.  Operation choices will have multiple acceptable input methods.

def collect(request_array)
  print "Please enter the first number: "
  request_array << gets.chomp
  exit if request_array[0].downcase == "exit"
  print "Please enter the second number: "
  request_array << gets.chomp 
  exit if request_array[1].downcase == "exit"
  print "Please select an operation: \n 1) Addition, 2) Subtraction, 3) Multiplication, 4) Division, 5) Exponential \n"
  request_array << gets.chomp.downcase
  exit if request_array[2] == "exit"
end


def convert(changing_array)
  begin
    # this is where things get tricky
    changing_array.unshift(changing_array[1].to_f)  # we take the *second* input *first* and add it at position (0).
    changing_array.delete_at(2)            # then we remove the original, which has been shifted from index (1) to index (2).
    changing_array.unshift(changing_array[1].to_f)  # then we repeat for the *first* element, now at position (1)
    changing_array.delete_at(2)            # Since (0) and (1) are the new float inputs, all that's left is to remove the new index (2).
  rescue
    puts "Invalid number(s).  Restarting..."    # but just in case one of these inputs isn't a number, we just leave without doing anything.
  end           # although I suspect this will not prevent the perform method from being executed...
end             # This has been confirmed.  It can still be salvaged by adding a similar begin/end to the perform method, 
                # however, this feels like cheating since I'm just covering for my inability to filter out the non-numerals before they 
                # make it to the perform method in the first place :-/


def perform(array)
  case array[2]
  when "1", "add", "addition"
    puts "The result is: #{(array[0] + array[1]).round(4)}"
  when "2", "subtract", "subtraction"
    puts "The result is: #{(array[0] - array[1]).round(4)}"
  when "3", "multiply", "multiplication"
    puts "The result is: #{(array[0] * array[1]).round(4)}"
  when "4", "divide", "division"
    puts "Remainder or decimal?"
    case gets.chomp.downcase
    when "remainder"
      puts "The result is: #{(array[0].to_i / array[1].to_i).floor} Remainder: #{(array[0].to_i % array[1].to_i)}"
    when "decimal"
      puts "The result is: #{(array[0] / array[1]).round(4)}"
    else
      puts "Did not understand.  Restarting..."
    end
  when "5", "exponent", "exponential"
    puts "The result is: #{(array[0] ** array[1]).round(4)}"
  else
    puts "Did not understand.  Restarting..."
  end
end

at_exit {puts "Thank you for using RubyCalc.  Goodbye."}


loop do
  puts "Welcome to RubyCalc.  Type 'exit' at any time to quit."
  calculation_array = []  
  collect(calculation_array)    # this method colllects input from the user as well as allowing an exit point.
  convert(calculation_array)    # this method converts the user's responses to floats, or exits the sequences and returns to the beginning if the input could not be made numeric.
  perform(calculation_array)    # this method performs the calculation, as well as allowing decimal devision or integer division with a remainder.
end