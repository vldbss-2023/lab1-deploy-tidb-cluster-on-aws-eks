#!/bin/bash

total=5000

pstr="[=======================================================================]"

# Create tables
mysql --host 127.0.0.1 --port 4000 -u root test -e "CREATE TABLE IF NOT EXISTS table1 (id INT AUTO_INCREMENT PRIMARY KEY, random_num FLOAT);";
mysql --host 127.0.0.1 --port 4000 -u root test -e "CREATE TABLE IF NOT EXISTS table2 (id INT AUTO_INCREMENT PRIMARY KEY, random_num FLOAT);";

# Insert data
for i in $(seq 1 $total)
do
   mysql --host 127.0.0.1 --port 4000 -u root test -e "INSERT INTO table1 VALUES (NULL, RAND());";
   mysql --host 127.0.0.1 --port 4000 -u root test -e "INSERT INTO table2 VALUES (NULL, RAND());";

   pd=$(( $i * 73 / $total ))
   printf "\r%3d.%1d%% %.${pd}s" $(( $i * 100 / $total )) $(( ($i * 1000 / $total) % 10 )) $pstr
done

# How to make up a SQL statement which takes very long time to complete, base on the tables created above?
# Pro tips: cross join.
