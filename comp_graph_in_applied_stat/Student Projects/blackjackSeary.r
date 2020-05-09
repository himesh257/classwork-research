#########################################################################
# Function sum_cards: sums the values of the cards in a blackjack hand. Aces
# are counted as either 11 or 1 depending on the sum total of non-ace cards in the hand
#
# Parameters:
# - hand: a blackjack hand that has been dealt to either a player or dealer. 
#
# NOTE: Blackjack hands in this simulation consist solely of integer values since the
#       cards do not need to be displayed graphically. Suits of cards also are irrelevant
#       for similar reasons
# ========================================================================

sum_cards <- function(hand) {
  
  aces <- FALSE
  ace_locs <- numeric()
  sum <- 0
  
  # if the hand is only 2 cards, just sum and exit
  if (length(hand) == 2) {
    sum <- hand[1] + hand[2]
    return(sum)
  }
  
  # find aces
  for (k in 1:length(hand)) {
    if(hand[k] == 11) {
      aces <- TRUE
      ace_locs <- c(ace_locs, k)
    }
  }
  
  # if no aces were found, sum all items and return
  if (aces == FALSE) {
    for (i in hand) {
       sum <- sum + i
    }
    return(sum)
  }
  
  # otherwise aces were found so first sum items that are NOT aces
  not_aces <- subset(hand, !(hand %in% c(11)))
  for (i in not_aces) {
    sum <- sum + i
  }
  
  # if sum of non-aces > 10 all aces must be treated as 1's
  if (sum > 10) {
    for (i in ace_locs) {
      sum <- sum + 1
    }
    return(sum)
  }
  
  # if sum of non-aces <= 9, need to check count of aces. 
  # If > 1 one can be treated as 11 while other must be treated as 1
  if (sum <= 9 & length(ace_locs) > 1) {
    sum <- sum + 11
    for (i in 1:(length(ace_locs) - 1)) {
      sum <- sum + 1
    }
    return(sum)
  }
  
  # if sum of non-aces == 10, need to check count of aces.
  # if == 1, then add 11 to sum and exit. if > 1, treat all aces as 1's
  if (sum == 10 & length(ace_locs) == 1) {
    sum <- sum + 11
    return(sum)
  } else {
    for (i in 1:length(ace_locs)) {
      sum <- sum + 1
    }
    return(sum)
  }
  
}

#########################################################################
# Function player_h: implements standard blackjack rules logic for the player's hand
# Parameters:
# - p_hand: the initial 2 cards dealt to the player
# - cards: a vector containing a pre-shuffled set of cards
# - i: an index variable that indicates the position of the card most recently dealt
#
# NOTE: Player strategy will be to take another card any time hand is 15 or less. This 
#       implies that the player will stand with any hand of 16 or greater.
# ========================================================================

player_h <- function(p_hand, cards, i, p_stand){

  ncards <- length(cards)
  stand <- FALSE
  
  while (stand != TRUE) {
    # sum current hand
    current <- sum_cards(p_hand)
  
    # if card index == number of cards in decks, time to stop
    if (i == ncards) {
      stand <- TRUE
      
    # else if hand is < p_stand value, take another card  
    } else if (current < p_stand) {
      i <- i + 1
      p_hand <- c(p_hand, cards[i])
    } else {
      stand <- TRUE
    }
    
  } # end while stand != TRUE
  
  return(c(current, i))
}

#########################################################################
# Function dealer_h: implements standard blackjack rules logic for the dealer's hand
# Parameters:
# - d_hand: the initial 2 cards dealt to the dealer
# - cards: a vector containing a pre-shuffled set of cards
# - i: an index variable that indicates the position of the card most recently dealt
#
# NOTE: Dealer MUST stand on hand total of 17 or greater, so any time dealer hand is <= 16
#       another card must be drawn
# ========================================================================

dealer_h <- function(d_hand, cards, i){
  
  ncards <- length(cards)
  stand <- FALSE
  
  while (stand != TRUE) {
    # sum current hand
    current <- sum_cards(d_hand)
    
    # if card index == number of cards in decks, time to stop
    if (i == ncards) {
      stand <- TRUE
      
    # else if hand is <= 16, take another card
    } else if (current <= 16) {
      i <- i + 1
      d_hand <- c(d_hand, cards[i])
    } else {
      stand <- TRUE
    }
    
  } # end while stand != TRUE

  return(c(current, i))
}

#########################################################################
# Function play_bj: plays blackjack until hand is over, then records player's
# winnings and losses
#
# Parameters:
# - cards: a pre-shuffled set of cards
# - bet: the dollar amount of bets placeable by the player for each blackjack hand
#
# NOTE: need to sample WITHOUT replacement from cards. Since they are 
# pre-shuffled before calling this function, just deal from top of deck and 
# use an index to keep track of which cards haven't been dealt
# ========================================================================

play_bj <- function(cards, bet, p_stand){
  
  # initialize the number of cards to be played
  ncards <- length(cards)
  
  # initialize index for cards
  i <- 0
  
  # initialize winnings accummulator
  winnings <- 0
 
  # New hand needed: check to see whether at least 4 cards remain unused
    if (i <= (ncards - 4)) {
      
      #### Deal 2 cards to player
      # increment card index
      i <- i + 2
      p_hand <- c(cards[i-1], cards[i])
      
      ### Deal 2 cards to dealer
      # increment card index
      i <- i + 2
      d_hand <- c(cards[i-1], cards[i])
      
    } else {
      # else cards are exhausted so exit
      return(winnings)
    }
    
    #### logic for player's hand
    p_res <- player_h(p_hand, cards, i, p_stand)
    
    # update card index
    i <- p_res[2]
    
    # if player didn't go over 21 then apply dealer hand logic
    if (p_res[1] <= 21) {
      d_res <- dealer_h(d_hand, cards, i)
      
      # update card index
      i <- d_res[2]
    }
    
    # ---------------------------------------------------------------
    # now compare player's hand to dealer's hand to find out who won
    
    # if player hand exceeded 21 subtract 1 from winnings
    if (p_res[1] > 21) {
      winnings <- winnings - 1
      
    # else if dealer went over 21 dealer has lost so add 1 to winnings  
    } else if (d_res[1] > 21) {
      winnings <- winnings + 1
      
    # else if player hand > dealer hand add 1 to winnings
    } else if (p_res[1] > d_res[1]) {
      winnings <- winnings + 1
      
    # else if player hand < dealer hand subtract 1 from winnings
    } else if (p_res[1] < d_res[1]) {
      winnings <- winnings - 1
    }
      
    
   # end hand
  return(winnings)
}
#########################################################################
# This is the actual simulation. This part affects what is calculated and printed when the script is run.

# NOTE: Suits of cards don't really matter at all. All we really need to track is the number remaining for each class of card, e.g., how many 2's, how many 3's, etc..

# set number of 2-deck sets to play
N <- 12

# set size of bets
bet <- 1

# set hand total for player to stand at
p_stand <- 16

# generate a deck of cards
deck <- rep(c(2:10, 10, 10, 10, 11), 4)

# create a set of cards consisting of a number of decks
two_d <- rep(deck,2)

# create a vector to store results of play
res <- data.frame(N = 1:12, winnings = numeric(N))

for (i in 1:N){
  # shuffle 2 new decks of cards
  s_decks <-sample(two_d,length(two_d), replace = FALSE)
  s_decks

  # play until 2 decks are exhausted
  res$winnings[i] <- play_bj(s_decks, bet, p_stand)
}

# create a table of winnings for each iteration
iteration <- 1:N
print('Sample of twelve rounds, standing at 16:')
print(res$winnings)

# average the winnings and print to screen
avg_winnings <- mean(res$winnings)
print('Average Winnings per Hand:')
print(avg_winnings)

# set number of simulation iterations to be run
iters <- 1000

# create a vector to store results of play
res2 <- data.frame(N = 1:iters, avg_winnings = numeric(iters))

for (k in 1:iters) {
  for (i in 1:N){
    # shuffle 2 new decks of cards
    s_decks <-sample(two_d,length(two_d), replace = FALSE)
    s_decks

    # play until 2 decks are exhausted
    res$winnings[i] <- play_bj(s_decks, bet, p_stand)
  } # for i

  # save the average the winnings to the results vector
  res2$avg_winnings[k] <- mean(res$winnings)
  
} # for k

set.seed(4444)

# create a vector to store the average winnings for various player "stand" values
playw <- data.frame(stand = 11:20, avg_winnings = numeric(10))

p_stand <- 11

standcol <- NULL
datacol <- NULL

for (z in 1:10) {
  res4 <- data.frame(N = 1:iters, avg_winnings = numeric(iters))

  for (k in 1:iters) {
    for (i in 1:N){
      # shuffle 2 new decks of cards
      s_decks <-sample(two_d,length(two_d), replace = FALSE)

      # play until round ends
      res$winnings[i] <- play_bj(s_decks, bet, p_stand)
    } # for i

  # average the winnings
  res4$avg_winnings[k] <- mean(res$winnings)
  standcol <- c(standcol, p_stand)

  } # for k

  # save the average winnings to the results vector
  playw$avg_winnings[z] <- mean(res4$avg_winnings)
  datacol <- c(datacol, res4$avg_winnings)
  # increase the player's stand value
  p_stand <- p_stand + 1

} # for z

print('Earnings after 1000 12-round sets for various stand values:')
print(playw)

standdata <- data.frame(stand = standcol, winnings = datacol)
standdata$stand <- as.factor(standdata$stand)

print('ANOVA for testing if strategies significantly differ:')

aov.out <- aov(winnings ~ stand, data = standdata)
print(summary(aov.out))

print('Using Tukey\'s procedure to compare between thresholds:')
ttest.out <- TukeyHSD(aov.out)
print(ttest.out)


p_stand <- 15 #sets ideal strategy
maxsize <- 12 #testing all deck sizes up to 12
sizechange <- data.frame(size = 1:maxsize, avg_winnings = numeric(maxsize))

sizecol <- NULL
datacol <- NULL

for (decksize in 1:maxsize)
{
	new_deck = rep(deck, decksize)
	res5 <- data.frame(N = 1:iters, avg_winnings = numeric(iters))
	for (k in 1:iters)
	{
		for (i in 1:N)
		{
			#shuffles decks
			shuffled <- sample(new_deck, length(new_deck), replace = FALSE)
			#play until round ends
			res$winnings[i] <- play_bj(shuffled, bet, p_stand)
		}
	res5$avg_winnings[k] <- mean(res$winnings)
	sizecol <- c(sizecol, decksize)
	}
	sizechange$avg_winnings[decksize] <- mean(res5$avg_winnings)
	datacol <- c(datacol, res5$avg_winnings)
}

print('Comparisons of stand at 15 strategy with different numbers of decks:')
print(sizechange)

realdata <- data.frame(size = sizecol, winnings = datacol)
print(summary(realdata$winnings))

print('Linear correlation between number of decks and winnings')
linearfit <- lm(winnings ~ size, data = realdata)
print(summary(linearfit))

print('Analysis of variance to find any significant differences between deck counts')
realdata$size <- as.factor(realdata$size)
aov.out <- aov(winnings ~ size, data = realdata)
print(summary(aov.out))
