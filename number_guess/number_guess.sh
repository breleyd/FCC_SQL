#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

echo "Enter your username:"
read NAME

USER_STATS=$($PSQL "SELECT games_played, best_game FROM users WHERE username='$NAME'")

# If USER_STATS is EMPTY (-z), they are a NEW user
if [[ -z $USER_STATS ]]
then
  echo "Welcome, $NAME! It looks like this is your first time here."
  # Insert new user so they exist for next time
  INSERT_USER_RESULT=$($PSQL "INSERT INTO users(username) VALUES('$NAME')")
else
  # If it is NOT empty, they are a RETURNING user
  echo "$USER_STATS" | while IFS="|" read GAMES_PLAYED BEST_GAME
  do
    echo "Welcome back, $NAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
  done
fi

SECRET=$(( $RANDOM % 1000 + 1 ))
echo "Guess the secret number between 1 and 1000:"
read GUESS

# regular expression for integers
re='^[0-9]+$'
counter=1

# While the input is NOT an integer
while [[ ! $GUESS =~ $re ]]
do
  echo "That is not an integer, guess again:"
  read GUESS # You MUST ask for input again inside the loop!
done

while [[ $GUESS -ne $SECRET ]]
do
  if [[ $GUESS -gt $SECRET ]]
  then
    echo "It's lower than that, guess again:"
  else
    echo "It's higher than that, guess again:"
  fi

  read GUESS
  ((counter++))
done

# Update total games played
((GAMES_PLAYED++))

# Check if it's a new personal best (or first game)
if [[ -z $BEST_GAME || $counter -lt $BEST_GAME ]]
then
  UPDATE_RESULT=$($PSQL "UPDATE users SET games_played = $GAMES_PLAYED, best_game = $counter WHERE username='$NAME'")
else
  UPDATE_RESULT=$($PSQL "UPDATE users SET games_played = $GAMES_PLAYED WHERE username='$NAME'")
fi

echo "You guessed it in $counter tries. The secret number was $SECRET. Nice job!"
