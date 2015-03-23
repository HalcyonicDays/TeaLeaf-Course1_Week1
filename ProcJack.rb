#!/usr/local/bin/ruby
NUMBER_OF_DECKS = 2
CARD_VALUES = "2, 3, 4, 5, 6, 7, 8, 9, 10, Jack, Queen, King, Ace" 
SUITS = "Hearts, Diamonds, Clubs, Spades"

deck = [] 
player = []   # represents the player
dealer = []   # respresents the computer opponent

def reset_deck_unsuited(deck)
  deck << CARD_VALUES.split(", ")
  deck * 4 * NUMBER_OF_DECKS
  deck.flatten!.shuffle!
end

def reset_deck_suited(deck)
  deck << CARD_VALUES.split(", ")
  deck * NUMBER_OF_DECKS
  deck.flatten!
  deck.replace ( deck.product(SUITS.split(", ")) )
  deck.shuffle!
end

def dealt_card(deck, users_hand)
  users_hand << deck.pop
end

def calculate_score(users_hand)
  point_total = 0
  total_aces = 0
  users_hand.each {|card| total_aces += card.count("A")}                # Count the total number of Aces because Aces are tricky.
  users_hand.each do |card|
    point_total += card[0].to_i unless card[0].to_i == 0                # Add numeric value to score
    point_total += 10 if card[0].to_i == 0 unless card[0] == "Ace"      # Add 10 for non-Ace non-numeric cards
  end
  point_total += total_aces                                           # Add 1 for each Ace.
  if total_aces >= 1
    (point_total + 10) > 21  ? point_total : point_total += 10        # Add an additional 0 or 10 for just one Ace.
  end
  point_total
end

def choice_validation_loop          
  puts "Would you like to hit or stay? (H)it / (S)tay."
  choice = gets.chomp[0].downcase 
  until ["h", "s"].include?(choice)
    puts "I didn't understand. Would you like to hit or stay? (H)it / (S)tay."
    choice = gets.chomp[0].downcase 
  end
  choice
end

def dealer_actions(deck, player, dealer)
  puts "\nThe dealer is showing a(n) #{dealer.last[0]} of #{dealer.last[1]}. \n"
  while calculate_score(dealer) < 17
    dealt_card(deck, dealer)
    puts "The Dealer hits."
    puts "Dealer draws a(n) #{dealer.last[0]} of #{dealer.last[1]}"
  end
  puts "The Dealer stays.\n"
  puts "The dealer has a final score of #{calculate_score(dealer)}."
end

def bust?(user)
  calculate_score(user) > 21
end

def blackjack?(user )
  calculate_score(user) == 21
end

system 'clear'
reset_deck_suited(deck)

2.times do 
  dealt_card(deck, player)
  puts "You've drawn a(n) #{player.last[0]} of #{player.last[1]}"}
end
2.times {dealt_card(deck, dealer)}

if blackjack?(player) || blackjack?(dealer)
  puts "Player has a blackjack!  Well done." if blackjack?(player)
  puts "Computer opponent has a blackjack. Tough luck." if blackjack?(dealer)
  puts "Double-Blackjack! What are the odds!? (0.07%)" if blackjack?(player) && blackjack?(dealer)
else
  puts "\nYou have a total of #{calculate_score(player)}."
  puts "\nThe dealer is showing a(n) #{dealer.last[0]} of #{dealer.last[1]}. \n"
  hit_or_stay = choice_validation_loop

  while hit_or_stay == "h"
    dealt_card(deck, player)
    puts "You've drawn a(n) #{player.last[0]} of #{player.last[1]}"
    puts "You now have a total of #{calculate_score(player)}."
    if bust?(player)
      puts "You've busted, so the dealer wins with #{calculate_score(dealer)}!"
      hit_or_stay = "s" 
    elsif blackjack?(player)
      puts "You've hit 21. Let's stop for now."
      hit_or_stay = "s" 
    else  
      hit_or_stay = choice_validation_loop
    end
  end

  puts "You have a final score of #{calculate_score(player)}." unless bust?(player)
  dealer_actions(deck, player, dealer) unless bust?(player) 
  puts "The dealer has busted at #{calculate_score(dealer)}! You win with #{calculate_score(player)}!" if bust?(dealer)

  if !bust?(player) && !bust?(dealer)
    if calculate_score(dealer) == calculate_score(player)
      puts "It's a push."
    elsif calculate_score(dealer) > calculate_score(player)
      puts "The dealer wins with a score of #{calculate_score(dealer)}."
    else
      puts "You win with #{calculate_score(player)}.  The dealer had only #{calculate_score(dealer)}."
    end
  end
end

puts "would you like to play again? (Y / N)"
answer = gets.chomp.downcase[0] 
exec 'ruby', 'ProcJack.rb' if answer == "y" && File.exists?('ProcJack.rb')
puts "Thanks for playing procedural Blackjack." if answer != "y"
