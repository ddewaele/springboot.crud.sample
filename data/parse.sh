#!/bin/bash

echo "Generating INSERT statements"
echo ""

while read line; do
  echo $line | awk -F "," '{printf("INSERT INTO EMPLOYEE(FIRST_NAME,LAST_NAME,EMAIL) VALUES('\''%s'\'','\''%s'\'','\''%s'\'');\n"),$2,$3,$4}'
done < employees.csv

echo "----------------------------------------------------------------------"

echo "Generating Curl statements"
echo ""

endpoint=localhost

while read line; do
  echo $line | awk -F "," '{printf("curl -X POST -H \"Content-Type: application/json\" -d '\''{ \"firstName\" : \"%s\", \"lastName\" : \"%s\", \"email\" : \"%s\" }'\'' http://localhost:8080/employees\n"),$2,$3,$4}'
done < employees.csv

echo "----------------------------------------------------------------------"
