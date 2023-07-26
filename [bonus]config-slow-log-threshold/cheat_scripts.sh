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

# Here is another example SQL query that could take a long time to execute on the two tables with random number data:
#
# SELECT *
# FROM table1 t1
# CROSS JOIN table2 t2
# WHERE t1.random_num < 50 OR t2.random_num > 50
# ORDER BY t1.random_num, t2.random_num;
#
# This performs a cross join, which produces a Cartesian product combining every row from table1 with every row from table2.
# It also has a filter condition on random_num which requires scanning all rows of both tables.
# Finally, it orders the gigantic result set by the random_num columns.
# As the tables grow bigger, the cost of the Cartesian product, filters, and sort make this query take progressively longer to complete.
# The cross join, scattered filters, and sorts are examples of expensive operations that commonly show up in slow queries, so this provides another representative case for testing.
