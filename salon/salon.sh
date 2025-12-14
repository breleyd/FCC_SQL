#! /bin/bash
PSQL="psql --username=freecodecamp --dbname=salon --no-align --tuples-only -c"

echo -e "\n~~~~~ MY SALON ~~~~~\n"
echo -e "Welcome to My Salon, how can I help you?\n"

MENU () {
  while true
  do
    $PSQL "SELECT service_id || ') ' || name FROM services"
    read SERVICE_ID_SELECTED
    if [[ ! "$SERVICE_ID_SELECTED" =~ ^[0-9]+$ ]] 
    then
      echo -e "\nI could not find that service. What would you like today?"
      continue
    fi

    SERVICE=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")

    if [[ -z $SERVICE ]]
    then
      echo -e "\nI could not find that service. What would you like today?"
      continue
    else
      break
    fi
  done
  GET_CONTACT $SERVICE_ID_SELECTED
}

GET_CONTACT () {
  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id=$1")
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")
  if [[ -z $CUSTOMER_NAME ]]
  then
    echo -e "\nI don't have a record for that phone number, what's your name?"
    read CUSTOMER_NAME
    $PSQL "INSERT INTO customers(phone,name) VALUES('$CUSTOMER_PHONE','$CUSTOMER_NAME')"
  fi

  echo -e "\nWhat time would you like your $SERVICE_NAME, $CUSTOMER_NAME?"
  read SERVICE_TIME
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
  $PSQL "INSERT INTO appointments(time,customer_id,service_id) VALUES('$SERVICE_TIME','$CUSTOMER_ID',$1)"

  echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
}

MENU
