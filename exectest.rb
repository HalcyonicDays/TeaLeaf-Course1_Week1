
at_exit {puts "the script has formally exited"}

puts "this is the script's beginning"

puts "repeat execution?"
answer = gets.chomp.downcase[0]

exec 'ruby', 'exectest.rb' if answer == "y"

puts "this is the script's end"
