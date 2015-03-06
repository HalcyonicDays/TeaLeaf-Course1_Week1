

def duel(hand_thrown, response)
  if response == hand_thrown[0]
    puts "I'm afraid it's a tie."
  else
    case hand_thrown[0]
    when "r"
      puts response == "p" ? "FWOOP; you've lost to paper." : "Yay! Rock smashes Scissors!"
    when "p"
      puts response == "s" ? "SNIPSNIP; you've lost to scissors." : "Yay! Paper covers Rock!"
    when "s"
      puts response == "r" ? "CRUNCH; you've lost to rock." : "Yay! Scissors cut Paper!"
    end
  end
end

def ai_response
  options = %w(r p s)
  response = options[rand(3)]
end

puts "Would you like to play Rock-Paper-Scissors? (Y/N)"
answer = gets.chomp.downcase

while answer == "y" do
  puts "Draw, varmint! (R / P / S)"
  hand_symbol = gets.chomp.downcase
  hand_symbol ||= ""
  duel(hand_symbol, ai_response) 
  puts "Would you like to play again? (Y/N)"
  answer = gets.chomp.downcase
end

