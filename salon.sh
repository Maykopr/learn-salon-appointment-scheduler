#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=salon -t -c"

echo -e "\n~~~~~ MY SALON ~~~~~\n"

MAIN_MENU () {
if [[ $1 ]]; then
  echo -e "\n$1"
fi

echo -e "1) cut\n2) color\n3) perm\n4) style\n5) trim"
read SERVICE_ID_SELECTED
if [[ ! $SERVICE_ID_SELECTED =~ ^[0-5]$ ]];then
  MAIN_MENU "I could not find that service. What would you like today?"
else
#busca o serviço na tabela pelo id
SERVICE_SELECTED=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")
#busca cliente por phone
echo "What's your phone number?"
read CUSTOMER_PHONE
CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")
  # se não temos o registro do cliente
  if [[ -z $CUSTOMER_NAME ]];then
  echo -e "\nI dont't have a record for that phone number, what's your name?"
  read CUSTOMER_NAME

  #registrando o cliente
  CUSTOMER_REGISTER=$($PSQL "INSERT INTO customers(name,phone) VALUES('$CUSTOMER_NAME','$CUSTOMER_PHONE')")
  fi
  echo "What time would you like your $SERVICE_SELECTED, $CUSTOMER_NAME?"
  read SERVICE_TIME
  echo -e "\nI have put you down for a cut at $SERVICE_TIME, $CUSTOMER_NAME."
  # fazendo o agendamento
  # o cliente não tem cadastro. Vamos registra-lo


fi



}
# EXIT
  # case $MAIN_MENU_SELECTION in
  #   1) APPOINTMENT_MENU ;;
  #   2) RETURN_MENU ;;
  #   3) EXIT ;;
  #   *) MAIN_MENU "Please enter a valid option." ;;
  # # esac
MAIN_MENU "Welcome to My Salon, how can I help you?\n"