#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else
  if [[ $1 =~ [1-10] ]]
  then
    
    NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number = '$1'")
    SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number = '$1'")
    NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number = '$1'")
    TYPE=$($PSQL "SELECT type FROM types FULL JOIN properties USING(type_id) WHERE atomic_number = '$1'")
    MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = '$1'")
    MELTING=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = '$1'")
    BOILING=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = '$1'")
    NUMBER_RESULT=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements FULL JOIN properties USING(atomic_number) FULL JOIN types USING(type_id) WHERE atomic_number = '$1'")
    echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
  
  else
    
    SYMBOL0=$($PSQL "SELECT symbol FROM elements WHERE symbol = '$1'")

    if [[ $1 = $SYMBOL0 ]]
    then

      NUMBER=$($PSQL "SELECT atomic_number FROM properties FULL JOIN elements USING (atomic_number) WHERE symbol = '$1'")
      SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE symbol = '$1'")
      NAME=$($PSQL "SELECT name FROM elements WHERE symbol = '$1'")
      TYPE=$($PSQL "SELECT type FROM types FULL JOIN properties USING(type_id) FULL JOIN elements USING (atomic_number) WHERE symbol = '$1'")
      MASS=$($PSQL "SELECT atomic_mass FROM properties FULL JOIN elements USING (atomic_number) WHERE symbol = '$1'")
      MELTING=$($PSQL "SELECT melting_point_celsius FROM properties FULL JOIN elements USING (atomic_number) WHERE symbol = '$1'")
      BOILING=$($PSQL "SELECT boiling_point_celsius FROM properties FULL JOIN elements USING (atomic_number) WHERE symbol = '$1'")
      echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."

    else

      NAME0=$($PSQL "SELECT name FROM elements WHERE name = '$1'")

      if [[ $1 = $NAME0 ]]
      then

        NUMBER=$($PSQL "SELECT atomic_number FROM properties FULL JOIN elements USING (atomic_number) WHERE name = '$1'")
        SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE name = '$1'")
        NAME=$($PSQL "SELECT name FROM elements WHERE name = '$1'")
        TYPE=$($PSQL "SELECT type FROM types FULL JOIN properties USING(type_id) FULL JOIN elements USING (atomic_number) WHERE name = '$1'")
        MASS=$($PSQL "SELECT atomic_mass FROM properties FULL JOIN elements USING (atomic_number) WHERE name = '$1'")
        MELTING=$($PSQL "SELECT melting_point_celsius FROM properties FULL JOIN elements USING (atomic_number) WHERE name = '$1'")
        BOILING=$($PSQL "SELECT boiling_point_celsius FROM properties FULL JOIN elements USING (atomic_number) WHERE name = '$1'")
        echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
      
      else
       
        echo "I could not find that element in the database."

      fi
    fi
  fi
fi
