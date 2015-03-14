# Requirements:
# - Player and Dealer both try to attain 21.
# - Numbered cards are worth their value.  Faces cards are worth 10.  Ace can be worth 1 or 11.
# - Player and Dealer are dealt 2 cards each.
# - After the deal, the player may choose to 'hit' (gain an additional card) or 'stay' (end card gain).
# - The player may continue to 'hit' for as long as they like, provided their score is < 21.  At 21, they win.  Above 21, they lose.
# - The dealer must 'hit' until they are >= 17, at which point they must 'stay'
# - Like the player, the dealer wins at 21, and loses above 21.
# - If neither Player nor Dealer have 21, and neither has gone over 21, the one with the higher score wins.

# Path:
# Step 1 is to create a Deck.  Thanks to reviewing another student's code, I have bypassed what would have been very difficult.
# This student created a product of a "suits" array and a "cards" array to create a deck with 52 2-element arrays.
# I would have simply created a suitless deck of cards; 4x Ace, 2, 3... 10, J, Q, K.  In fact, I see no programmatic value in a suited deck; only an asthetic one.
#   Edit: The value is thus: it creates an array with 52 unique values, rather than merely 13 unique values.  If you use array.delete(), you need unique values or else you lose all of them. 
#   I get around this because you only need unique values if you use array.sample.  If you use array.shuffle!, then you can just array.pop the "top" card off the deck and into someone's hand.
# Step 2 could be to shuffle the deck, at which point I would write a shuffle method or look one up.
# I think it would be move efficient to simply use i = array.sample() followed by array.delete(i) and hand << i.  This would called deal card.
# For Readability's sake, there could be separate "random card" "deal card" and "remove from deck" methods, but I remain unconvinced that such fragmentation is the best practice.
# Even so, I will focus on having a method do exactly one thing, for sake of practicing.
# Step 3 - after the player has a hand (array) of size 2, the score is totaled and returned.  Options are presented to 'hit' or 'stay'
# Step 4 - 'hit' repeats the "deal card" method.
# Step 5 - Unless someone has won or lost outright, the game proceeds to the "compare scores" phase.  Also, I should look up who wins ties. Probably the House.
# ALSO! It's very important to remember that ONE of the Dealer's cards is always hidden from the Player.  If the dealer had an AI, the reverse would also be true for the Dealer.

NUMBER_OF_DECKS = 2
CARD_VALUES = "2, 3, 4, 5, 6, 7, 8, 9, 10, Jack, Queen, King, Ace" 
SUITS = "Hearts, Diamonds, Clubs, Spades"

deck = [] 
player = []   # represents the player
dealer = []   # respresents the computer opponent

# How to calculate score is the most challenging, as far as I can tell.  Options include:
# (1) A hash containing each card value as a key, and it's corresponding value as value.
# (2) A hash containing only the non-numeric keys and their corresponding values (10 or 11 for Aces).
# (3) player[element].each {score += player[elment].to_i unless player[elment].to_i == 0} and a nested if of count += 10 unless "Ace"
#     Followed by a ternary operator to decide if "Ace" should be 11 or 1.
#  Yeah, let's do that last one.  Simplicity is Elegance.
 
# Note for later: learn how to declare variables/objects in a way appropriate to their scope.  Globally declarations are not an acceptable practice.

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

def dealt_card(deck, user)
  user << deck.pop
end

def calculate_score(user)
  point_total = 0
  total_aces = 0
  user.each {|elm| total_aces+= elm.count("Ace")}                     # Count the total number of Aces because Aces are tricky.
  user.each do |elm|
    point_total += elm[0].to_i unless elm[0].to_i == 0                # Add numeric value to score
    point_total += 10 if elm[0].to_i == 0 unless elm[0] == "Ace"      # Add 10 for non-Ace non-numeric cards
  end
  point_total += total_aces                                       # Add 1 for each Ace.
  (point_total + 10) > 21  ? point_total : point_total += 10      # Add an additional 0 or 10 for just one Ace.
end

def choice_validation_loop
  puts "Would you like to hit or stay? (H)it / (S)tay."
  choice = gets.chomp[0].downcase 
  until choice == "h" || choice ==  "s"
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
  calculate_score(user)>21
end

def blackjack?(user )
  calculate_score(user) == 21
end
##############################################################################################################
system 'clear'
reset_deck_suited(deck)

2.times {dealt_card(deck, player); puts "You've drawn a(n) #{player.last[0]} of #{player.last[1]}"}
2.times {dealt_card(deck, dealer)}

if blackjack?(player) || blackjack?(dealer)
  puts "Player has a blackjack!  Well done." if blackjack?(player)
  puts "Computer opponent has a blackjack. Tough luck." if blackjack?(dealer)
  puts "Double-Blackjack! What are the odds!? (0.07%)" if blackjack?(player) && blackjack?(dealer)
else
  puts "\nYou are showing a total of #{calculate_score(player)}."
  puts "\nThe dealer is showing a(n) #{dealer.last[0]} of #{dealer.last[1]}. \n"
  hit_or_stay = choice_validation_loop

  while hit_or_stay == "h"
    dealt_card(deck, player)
    puts "You've drawn a(n) #{player.last[0]} of #{player.last[1]}"
    puts "You're now showing a total of #{calculate_score(player)}."
    if bust?(player)
      puts "You've busted!"
      hit_or_stay = "s" 
    elsif blackjack?(player)
      puts "You've hit 21. Let's stop for now."
      hit_or_stay = "s" 
    else  
      hit_or_stay = choice_validation_loop
    end
  end

  puts "You have a final score of #{calculate_score(player)}." unless bust?(player)
  puts "You've busted, so the dealer wins with #{calculate_score(dealer)}!" if bust?(player)

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
exec 'ruby', 'ProcJack.rb' if answer == "y"
puts "Thanks for playing procedural Blackjack." if answer != "y"

# Bonus items:
# (1) Give the player a name.  This is done by turning "player" into a 2D array with the name stored in the second portion and replacing "player" with "player[0]" when it is being passed.
#     Alternatively, a hash table can be created of the form, { "player name" => player[] } such that the value is the "player[]" variable representing the player's hand.
# (2) Ask the player to play again - this can be accomplished in *yet another* bigger outside while loop.
#     Alternatively, put lines 94-138 inside a method and loop through the method while "play_again == 'y'" or something to that effect.
# (3) You could create a suited deck by perfroming deck = CARD_VALUES.product(SUITS).  Now every entry in the player (or dealer) array is ["card", "suit"] so I just update
#     calculate_score to take elm[0].to_i where currently it takes elm.to_i so that it operates on the card value portion of the card.
#     I would also update "You've drawn a(n) #{player.last[0]} of #{player.last[1]}" for the player and dealer messages.
# (4) Rather than explaining this, I just added it into my reset_deck method.  The computer doesn't care how large the array is, so the functionality is identical.
