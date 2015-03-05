# This calculator will handle addition, subtraction, multiplication, and division (with and without remainders)
# Furthermore, it can raise a number to an exponent.  There will be an accuracy out to 4 decimal places.
# Acceptable input will be numeric.  Operation choices will have multiple acceptable input methods.

def selection(array)
  print "Please enter the first number: "
  array << gets.chomp
  exit if array[0].downcase == "exit"
  print "Please enter the second number: "
  array << gets.chomp 
  exit if array[1].downcase == "exit"
  print "Please select an operation: \n 1) Addition, 2) Subtraction, 3) Multiplication, 4) Division, 5) Exponential \n"
  array << gets.chomp.downcase
  exit if array[2] == "exit"
end

def convert(array)
  begin
    array << array[0].to_f
    array << array[1].to_f
    array.delete_at(0)
    array.delete_at(0)
  rescue
    puts "Invalid numbers.  Restarting..."
  end
end

def perform(array)
  case array[0]
  when "1", "add", "addition"
    puts "The result is: #{(array[1] + array[2]).round(4)}"
  when "2", "subtract", "subtraction"
    puts "The result is: #{(array[1] - array[2]).round(4)}"
  when "3", "multiply", "multiplication"
    puts "The result is: #{(array[1] * array[2]).round(4)}"
  when "4", "divide", "division"
    puts "Remainder or decimal?"
    case gets.chomp.downcase
    when "remainder"
      puts "The result is: #{(array[1].to_i / array[2].to_i).floor} Remainder: #{(array[1].to_i % array[2].to_i)}"
    when "decimal"
      puts "The result is: #{(array[1] / array[2]).round(4)}"
    else
      puts "Did not understand.  Restarting..."
    end
  when "5", "exponent", "exponential"
    puts "The result is: #{(array[1] ** array[2]).round(4)}"
  else
    puts "Did not understand.  Restarting..."
  end
end

at_exit {puts "Thank you for using RubyCalc.  Goodbye."}


while true do
  puts "Welcome to RubyCalc.  Type 'exit' at any time to quit."
  array = []  
  selection(array)
  convert(array)
  perform(array)
end