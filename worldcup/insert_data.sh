#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
tail -n +2 games.csv | while IFS=, read -r YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  # escape single quotes 
  WINNER_ESC=$(echo "$WINNER" | sed "s/'/''/g")
  OPP_ESC=$(echo "$OPPONENT" | sed "s/'/''/g")

  # insert teams (duplicates ignored)
  $PSQL "INSERT INTO teams(name) VALUES('$WINNER_ESC') ON CONFLICT (name) DO NOTHING;"
  $PSQL "INSERT INTO teams(name) VALUES('$OPP_ESC') ON CONFLICT (name) DO NOTHING;"

  # get team IDs (psql returns just the number because of -t --no-align)
  WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER_ESC';")
  OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPP_ESC';")

  # trim whitespace/newlines just in case
  WINNER_ID=$(echo "$WINNER_ID" | tr -d '[:space:]')
  OPPONENT_ID=$(echo "$OPPONENT_ID" | tr -d '[:space:]')

  # insert the game (IDs are numeric — do NOT wrap them in quotes)
  $PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS);"
done
