# Rock-paper-scissors-lizard-Spock Mini Project

import random

def name_to_number(name):
    if name == "rock":
        return 0
    elif name == "Spock":
        return 1
    elif name == "paper":
        return 2
    elif name == "lizard":
        return 3
    elif name == "scissors":
        return 4
    else:
        return 100

def number_to_name(number):
    if number == 0:
        return "rock"
    elif number == 1:
        return "Spock"
    elif number == 2:
        return "paper"
    elif number == 3:
        return "lizard"
    elif number == 4:
        return "scissors"
    else:
        return "invalid number!"

def rpsls(player_choice): 
    print ""
    print "Player chooses " + player_choice
    
    computer_choice = random.randrange(0, 5)
    print "Computer chooses " + number_to_name(computer_choice)
    
    game_result = (name_to_number(player_choice) - computer_choice) % 5
    if game_result == 1 or game_result == 2:
        print "Player wins!"
    elif game_result == 3 or game_result == 4:
        print "Computer wins!"
    elif game_result == 0:
        print "Player and computer tie!"
    else:
        print "Error!"
    
# test calls
rpsls("rock")
rpsls("Spock")
rpsls("paper")
rpsls("lizard")
rpsls("scissors")
