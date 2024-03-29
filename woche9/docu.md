# Query 1
## Zu Beginn  -  506ms
+-------------------------------------------------------------------------------------------+
|| Id  | Operation                     | Name      | Rows  | Bytes | Cost (%CPU)| Time     ||
|-------------------------------------------------------------------------------------------|
||   0 | SELECT STATEMENT              |           |     1 |    81 |   119   (1)| 00:00:01 ||
||   1 |  SORT ORDER BY                |           |     1 |    81 |   119   (1)| 00:00:01 ||
||   2 |   NESTED LOOPS                |           |     1 |    81 |   118   (0)| 00:00:01 ||
||   3 |    NESTED LOOPS               |           |     1 |    81 |   118   (0)| 00:00:01 ||
||*  4 |     HASH JOIN                 |           |     1 |    62 |   117   (0)| 00:00:01 ||
||*  5 |      TABLE ACCESS FULL        | CUSTOMERS |     1 |    34 |    56   (0)| 00:00:01 ||
||   6 |      TABLE ACCESS FULL        | ADDRESSES | 23941 |   654K|    61   (0)| 00:00:01 ||
||*  7 |     INDEX UNIQUE SCAN         | ATP_PK    |     1 |       |     0   (0)| 00:00:01 ||
||   8 |    TABLE ACCESS BY INDEX ROWID| ADR_TYPES |     1 |    19 |     1   (0)| 00:00:01 ||
|-------------------------------------------------------------------------------------------|
|                                                                                           |
|Predicate Information (identified by operation id):                                        |
|---------------------------------------------------                                        |
|                                                                                           |
|   4 - access("A"."CUST_ID"="C"."ID")                                                      |
|   5 - filter("C"."LAST_NAME"='Koenig' AND "C"."FIRST_NAME"='Susanne')                     |
|   7 - access("ATP"."ADR_TYPE"="A"."ADR_TYPE")                                             |
+-------------------------------------------------------------------------------------------+

## Nach Index
+------------------------------------------------------------------------------------------------------+
|| Id  | Operation                               | Name       | Rows  | Bytes | Cost (%CPU)| Time     ||
|------------------------------------------------------------------------------------------------------|
||   0 | SELECT STATEMENT                        |            |     1 |    81 |    65   (2)| 00:00:01 ||
||   1 |  SORT ORDER BY                          |            |     1 |    81 |    65   (2)| 00:00:01 ||
||   2 |   NESTED LOOPS                          |            |     1 |    81 |    64   (0)| 00:00:01 ||
||   3 |    NESTED LOOPS                         |            |     1 |    81 |    64   (0)| 00:00:01 ||
||*  4 |     HASH JOIN                           |            |     1 |    62 |    63   (0)| 00:00:01 ||
||   5 |      TABLE ACCESS BY INDEX ROWID BATCHED| CUSTOMERS  |     1 |    34 |     2   (0)| 00:00:01 ||
||*  6 |       INDEX RANGE SCAN                  | CUST_LN_FN |     1 |       |     1   (0)| 00:00:01 ||
||   7 |      TABLE ACCESS FULL                  | ADDRESSES  | 23941 |   654K|    61   (0)| 00:00:01 ||
||*  8 |     INDEX UNIQUE SCAN                   | ATP_PK     |     1 |       |     0   (0)| 00:00:01 ||
||   9 |    TABLE ACCESS BY INDEX ROWID          | ADR_TYPES  |     1 |    19 |     1   (0)| 00:00:01 ||
|------------------------------------------------------------------------------------------------------|
|                                                                                                      |
|Predicate Information (identified by operation id):                                                   |
|---------------------------------------------------                                                   |
|                                                                                                      |
|   4 - access("A"."CUST_ID"="C"."ID")                                                                 |
|   6 - access("C"."LAST_NAME"='Koenig' AND "C"."FIRST_NAME"='Susanne')                                |
|   8 - access("ATP"."ADR_TYPE"="A"."ADR_TYPE")                                                        |
+------------------------------------------------------------------------------------------------------+


# Query 2
## Zu Beginn  -  82 ms
+----------------------------------------------------------------------------------+
|| Id  | Operation            | Name      | Rows  | Bytes | Cost (%CPU)| Time     ||
|----------------------------------------------------------------------------------|
||   0 | SELECT STATEMENT     |           |    10 |  1000 |   121   (1)| 00:00:01 ||
||   1 |  SORT ORDER BY       |           |    10 |  1000 |   121   (1)| 00:00:01 ||
||*  2 |   HASH JOIN          |           |    10 |  1000 |   120   (0)| 00:00:01 ||
||*  3 |    HASH JOIN         |           |    10 |   810 |   117   (0)| 00:00:01 ||
||*  4 |     TABLE ACCESS FULL| CUSTOMERS |     7 |   182 |    56   (0)| 00:00:01 ||
||   5 |     TABLE ACCESS FULL| ADDRESSES | 23941 |  1285K|    61   (0)| 00:00:01 ||
||   6 |    TABLE ACCESS FULL | ADR_TYPES |     3 |    57 |     3   (0)| 00:00:01 ||
|----------------------------------------------------------------------------------|
|                                                                                  |
|Predicate Information (identified by operation id):                               |
|---------------------------------------------------                               |
|                                                                                  |
|   2 - access("ATP"."ADR_TYPE"="A"."ADR_TYPE")                                    |
|   3 - access("A"."CUST_ID"="C"."ID")                                             |
|   4 - filter("C"."LAST_NAME"='Moneypenny')                                       |
+----------------------------------------------------------------------------------+

## Nach Index
+-----------------------------------------------------------------------------------------------------+
|| Id  | Operation                              | Name       | Rows  | Bytes | Cost (%CPU)| Time     ||
|-----------------------------------------------------------------------------------------------------|
||   0 | SELECT STATEMENT                       |            |    10 |  1000 |    74   (2)| 00:00:01 ||
||   1 |  SORT ORDER BY                         |            |    10 |  1000 |    74   (2)| 00:00:01 ||
||*  2 |   HASH JOIN                            |            |    10 |  1000 |    73   (0)| 00:00:01 ||
||*  3 |    HASH JOIN                           |            |    10 |   810 |    70   (0)| 00:00:01 ||
||   4 |     TABLE ACCESS BY INDEX ROWID BATCHED| CUSTOMERS  |     7 |   182 |     9   (0)| 00:00:01 ||
||*  5 |      INDEX RANGE SCAN                  | CUST_LN_FN |     7 |       |     2   (0)| 00:00:01 ||
||   6 |     TABLE ACCESS FULL                  | ADDRESSES  | 23941 |  1285K|    61   (0)| 00:00:01 ||
||   7 |    TABLE ACCESS FULL                   | ADR_TYPES  |     3 |    57 |     3   (0)| 00:00:01 ||
|-----------------------------------------------------------------------------------------------------|
|                                                                                                     |
|Predicate Information (identified by operation id):                                                  |
|---------------------------------------------------                                                  |
|                                                                                                     |
|   2 - access("ATP"."ADR_TYPE"="A"."ADR_TYPE")                                                       |
|   3 - access("A"."CUST_ID"="C"."ID")                                                                |
|   5 - access("C"."LAST_NAME"='Moneypenny')                                                          |
+-----------------------------------------------------------------------------------------------------+


# Query 3
## Zu Beginn  -  1s 460ms
+---------------------------------------------------------------------------------+
|| Id  | Operation           | Name      | Rows  | Bytes | Cost (%CPU)| Time     ||
|---------------------------------------------------------------------------------|
||   0 | SELECT STATEMENT    |           |  2447 | 95433 |  1796   (3)| 00:00:01 ||
||   1 |  HASH UNIQUE        |           |  2447 | 95433 |  1796   (3)| 00:00:01 ||
||*  2 |   HASH JOIN SEMI    |           |  2447 | 95433 |  1795   (3)| 00:00:01 ||
||*  3 |    TABLE ACCESS FULL| CUSTOMERS |  2447 | 63622 |    56   (0)| 00:00:01 ||
||*  4 |    TABLE ACCESS FULL| ORDERS    | 19465 |   247K|  1738   (3)| 00:00:01 ||
|---------------------------------------------------------------------------------|
|                                                                                 |
|Predicate Information (identified by operation id):                              |
|---------------------------------------------------                              |
|                                                                                 |
|   2 - access("C"."ID"="O"."CUST_ID")                                            |
|   3 - filter("C"."MEMBER_FLAG"='Y' AND "C"."LANGUAGE_CODE"='en')                |
|   4 - filter(TO_CHAR(INTERNAL_FUNCTION("O"."ORDER_DATE"),'dd.mm.yyyy')='        |
|              02.03.2020')                                                       |
+---------------------------------------------------------------------------------+

## Anpassung Query
+---------------------------------------------------------------------------------+
|| Id  | Operation           | Name      | Rows  | Bytes | Cost (%CPU)| Time     ||
|---------------------------------------------------------------------------------|
||   0 | SELECT STATEMENT    |           |  1775 | 69225 |  1769   (1)| 00:00:01 ||
||   1 |  HASH UNIQUE        |           |  1775 | 69225 |  1769   (1)| 00:00:01 ||
||*  2 |   HASH JOIN         |           |  1775 | 69225 |  1767   (1)| 00:00:01 ||
||*  3 |    TABLE ACCESS FULL| ORDERS    |  1776 | 23088 |  1711   (1)| 00:00:01 ||
||*  4 |    TABLE ACCESS FULL| CUSTOMERS |  2447 | 63622 |    56   (0)| 00:00:01 ||
|---------------------------------------------------------------------------------|
|                                                                                 |
|Predicate Information (identified by operation id):                              |
|---------------------------------------------------                              |
|                                                                                 |
|   2 - access("C"."ID"="O"."CUST_ID")                                            |
|   3 - filter("O"."ORDER_DATE"=TO_DATE(' 2020-03-02 00:00:00',                   |
|              'syyyy-mm-dd hh24:mi:ss'))                                         |
|   4 - filter("C"."MEMBER_FLAG"='Y' AND "C"."LANGUAGE_CODE"='en')                |
+---------------------------------------------------------------------------------+


# Query 4
## Zu Beginn  -  98ms
+--------------------------------------------------------------------------------+
|| Id  | Operation          | Name      | Rows  | Bytes | Cost (%CPU)| Time     ||
|--------------------------------------------------------------------------------|
||   0 | SELECT STATEMENT   |           |    81 |  4374 |   118   (1)| 00:00:01 ||
||*  1 |  HASH JOIN         |           |    81 |  4374 |   118   (1)| 00:00:01 ||
||*  2 |   TABLE ACCESS FULL| ADDRESSES |    81 |  2025 |    61   (0)| 00:00:01 ||
||   3 |   TABLE ACCESS FULL| CUSTOMERS | 16332 |   462K|    56   (0)| 00:00:01 ||
|--------------------------------------------------------------------------------|
|                                                                                |
|Predicate Information (identified by operation id):                             |
|---------------------------------------------------                             |
|                                                                                |
|   1 - access("A"."CUST_ID"="C"."ID")                                           |
|   2 - filter("A"."ADR_TYPE"='P' AND "A"."ZIP_CODE"||'                          |
|              '||"A"."CITY"='5210 Windisch')                                    |
+--------------------------------------------------------------------------------+

## Anpassung Query
+------------------------------------------------------------------------------------------+
|| Id  | Operation                    | Name      | Rows  | Bytes | Cost (%CPU)| Time     ||
|------------------------------------------------------------------------------------------|
||   0 | SELECT STATEMENT             |           |     1 |    54 |    62   (0)| 00:00:01 ||
||   1 |  NESTED LOOPS                |           |     1 |    54 |    62   (0)| 00:00:01 ||
||   2 |   NESTED LOOPS               |           |     1 |    54 |    62   (0)| 00:00:01 ||
||*  3 |    TABLE ACCESS FULL         | ADDRESSES |     1 |    25 |    61   (0)| 00:00:01 ||
||*  4 |    INDEX UNIQUE SCAN         | CUST_PK   |     1 |       |     0   (0)| 00:00:01 ||
||   5 |   TABLE ACCESS BY INDEX ROWID| CUSTOMERS |     1 |    29 |     1   (0)| 00:00:01 ||
|------------------------------------------------------------------------------------------|
|                                                                                          |
|Predicate Information (identified by operation id):                                       |
|---------------------------------------------------                                       |
|                                                                                          |
|   3 - filter("A"."CITY"='Windisch' AND "A"."ZIP_CODE"='5210' AND                         |
|              "A"."ADR_TYPE"='P')                                                         |
|   4 - access("A"."CUST_ID"="C"."ID")                                                     |
+------------------------------------------------------------------------------------------+

## Hinzufügen vom Index
+---------------------------------------------------------------------------------------------------+
|| Id  | Operation                             | Name      | Rows  | Bytes | Cost (%CPU)| Time     ||
|---------------------------------------------------------------------------------------------------|
||   0 | SELECT STATEMENT                      |           |     1 |    54 |     3   (0)| 00:00:01 ||
||   1 |  NESTED LOOPS                         |           |     1 |    54 |     3   (0)| 00:00:01 ||
||   2 |   NESTED LOOPS                        |           |     1 |    54 |     3   (0)| 00:00:01 ||
||*  3 |    TABLE ACCESS BY INDEX ROWID BATCHED| ADDRESSES |     1 |    25 |     2   (0)| 00:00:01 ||
||*  4 |     INDEX RANGE SCAN                  | ADR_ZI_CI |     1 |       |     1   (0)| 00:00:01 ||
||*  5 |    INDEX UNIQUE SCAN                  | CUST_PK   |     1 |       |     0   (0)| 00:00:01 ||
||   6 |   TABLE ACCESS BY INDEX ROWID         | CUSTOMERS |     1 |    29 |     1   (0)| 00:00:01 ||
|---------------------------------------------------------------------------------------------------|
|                                                                                                   |
|Predicate Information (identified by operation id):                                                |
|---------------------------------------------------                                                |
|                                                                                                   |
|   3 - filter("A"."ADR_TYPE"='P')                                                                  |
|   4 - access("A"."ZIP_CODE"='5210' AND "A"."CITY"='Windisch')                                     |
|   5 - access("A"."CUST_ID"="C"."ID")                                                              |
+---------------------------------------------------------------------------------------------------+



# Query 5
## Zu Beginn  -  937ms
+------------------------------------------------------------------------------------------------------+
|| Id  | Operation                              | Name        | Rows  | Bytes | Cost (%CPU)| Time     ||
|------------------------------------------------------------------------------------------------------|
||   0 | SELECT STATEMENT                       |             |     1 |    93 |  1774   (1)| 00:00:01 ||
||   1 |  NESTED LOOPS                          |             |     1 |    93 |  1774   (1)| 00:00:01 ||
||   2 |   NESTED LOOPS                         |             |     1 |    93 |  1774   (1)| 00:00:01 ||
||   3 |    NESTED LOOPS                        |             |     1 |    47 |  1773   (1)| 00:00:01 ||
||*  4 |     HASH JOIN                          |             |     1 |    38 |  1770   (1)| 00:00:01 ||
||*  5 |      TABLE ACCESS FULL                 | CUSTOMERS   |     1 |    21 |    56   (0)| 00:00:01 ||
||   6 |      TABLE ACCESS FULL                 | ORDERS      |  1946K|    31M|  1709   (1)| 00:00:01 ||
||   7 |     TABLE ACCESS BY INDEX ROWID BATCHED| ORDER_ITEMS |     4 |    36 |     3   (0)| 00:00:01 ||
||*  8 |      INDEX RANGE SCAN                  | ORDI_UK     |     4 |       |     2   (0)| 00:00:01 ||
||*  9 |    INDEX UNIQUE SCAN                   | PROD_PK     |     1 |       |     0   (0)| 00:00:01 ||
||* 10 |   TABLE ACCESS BY INDEX ROWID          | PRODUCTS    |     1 |    46 |     1   (0)| 00:00:01 ||
|------------------------------------------------------------------------------------------------------|
|                                                                                                      |
|Predicate Information (identified by operation id):                                                   |
|---------------------------------------------------                                                   |
|                                                                                                      |
|   4 - access("C"."ID"="O"."CUST_ID")                                                                 |
|   5 - filter("C"."FIRST_NAME"='James' AND "C"."LAST_NAME"='Bond')                                    |
|   8 - access("I"."ORDER_ID"="O"."ID")                                                                |
|   9 - access("P"."ID"="I"."PROD_ID")                                                                 |
|  10 - filter("P"."PROD_CATEGORY"='Hardware')                                                         |
+------------------------------------------------------------------------------------------------------+

## Durch Index Query 1 - 1s 321ms
+-------------------------------------------------------------------------------------------------------+
|| Id  | Operation                               | Name        | Rows  | Bytes | Cost (%CPU)| Time     ||
|-------------------------------------------------------------------------------------------------------|
||   0 | SELECT STATEMENT                        |             |     1 |    93 |  1720   (1)| 00:00:01 ||
||   1 |  NESTED LOOPS                           |             |     1 |    93 |  1720   (1)| 00:00:01 ||
||   2 |   NESTED LOOPS                          |             |     1 |    93 |  1720   (1)| 00:00:01 ||
||   3 |    NESTED LOOPS                         |             |     1 |    47 |  1719   (1)| 00:00:01 ||
||*  4 |     HASH JOIN                           |             |     1 |    38 |  1716   (1)| 00:00:01 ||
||   5 |      TABLE ACCESS BY INDEX ROWID BATCHED| CUSTOMERS   |     1 |    21 |     2   (0)| 00:00:01 ||
||*  6 |       INDEX RANGE SCAN                  | CUST_LN_FN  |     1 |       |     1   (0)| 00:00:01 ||
||   7 |      TABLE ACCESS FULL                  | ORDERS      |  1946K|    31M|  1709   (1)| 00:00:01 ||
||   8 |     TABLE ACCESS BY INDEX ROWID BATCHED | ORDER_ITEMS |     4 |    36 |     3   (0)| 00:00:01 ||
||*  9 |      INDEX RANGE SCAN                   | ORDI_UK     |     4 |       |     2   (0)| 00:00:01 ||
||* 10 |    INDEX UNIQUE SCAN                    | PROD_PK     |     1 |       |     0   (0)| 00:00:01 ||
||* 11 |   TABLE ACCESS BY INDEX ROWID           | PRODUCTS    |     1 |    46 |     1   (0)| 00:00:01 ||
|-------------------------------------------------------------------------------------------------------|
|                                                                                                       |
|Predicate Information (identified by operation id):                                                    |
|---------------------------------------------------                                                    |
|                                                                                                       |
|   4 - access("C"."ID"="O"."CUST_ID")                                                                  |
|   6 - access("C"."LAST_NAME"='Bond' AND "C"."FIRST_NAME"='James')                                     |
|   9 - access("I"."ORDER_ID"="O"."ID")                                                                 |
|  10 - access("P"."ID"="I"."PROD_ID")                                                                  |
|  11 - filter("P"."PROD_CATEGORY"='Hardware')                                                          |
+-------------------------------------------------------------------------------------------------------+


# Query 6
## Zu Beginn  -  191ms
+-------------------------------------------------------------------------------------------+
|| Id  | Operation                     | Name      | Rows  | Bytes | Cost (%CPU)| Time     ||
|-------------------------------------------------------------------------------------------|
||   0 | SELECT STATEMENT              |           |     1 |   103 |  1814   (1)| 00:00:01 ||
||*  1 |  HASH JOIN ANTI               |           |     1 |   103 |  1814   (1)| 00:00:01 ||
||   2 |   NESTED LOOPS                |           |    34 |  3060 |   102   (1)| 00:00:01 ||
||   3 |    NESTED LOOPS               |           |    34 |  3060 |   102   (1)| 00:00:01 ||
||   4 |     VIEW                      | VW_NSO_1  |    34 |   442 |    67   (0)| 00:00:01 ||
||   5 |      HASH UNIQUE              |           |    34 |  1496 |            |          ||
||*  6 |       HASH JOIN               |           |    34 |  1496 |    67   (0)| 00:00:01 ||
||   7 |        MERGE JOIN CARTESIAN   |           |     1 |    33 |     6   (0)| 00:00:01 ||
||*  8 |         TABLE ACCESS FULL     | ADR_TYPES |     1 |    19 |     3   (0)| 00:00:01 ||
||   9 |         BUFFER SORT           |           |     1 |    14 |     3   (0)| 00:00:01 ||
||* 10 |          TABLE ACCESS FULL    | COUNTRIES |     1 |    14 |     3   (0)| 00:00:01 ||
||  11 |        TABLE ACCESS FULL      | ADDRESSES | 23941 |   257K|    61   (0)| 00:00:01 ||
||* 12 |     INDEX UNIQUE SCAN         | CUST_PK   |     1 |       |     0   (0)| 00:00:01 ||
||  13 |    TABLE ACCESS BY INDEX ROWID| CUSTOMERS |     1 |    77 |     1   (0)| 00:00:01 ||
||* 14 |   TABLE ACCESS FULL           | ORDERS    |   108K|  1376K|  1711   (1)| 00:00:01 ||
|-------------------------------------------------------------------------------------------|
|                                                                                           |
|Predicate Information (identified by operation id):                                        |
|---------------------------------------------------                                        |
|                                                                                           |
|   1 - access("ID"="CUST_ID")                                                              |
|   6 - access("ATP"."ADR_TYPE"="A"."ADR_TYPE" AND "CTR"."CODE"="A"."CTR_CODE")             |
|   8 - filter("ATP"."LABEL"='Delivery address')                                            |
|  10 - filter("CTR"."NAME"='Switzerland')                                                  |
|  12 - access("ID"="CUST_ID")                                                              |
|  14 - filter("ORDER_DATE">=TO_DATE(' 2023-01-01 00:00:00', 'syyyy-mm-dd                   |
|              hh24:mi:ss') AND "ORDER_DATE"<=TO_DATE(' 2023-12-31 00:00:00', 'syyyy-mm-dd  |
|              hh24:mi:ss'))                                                                |
+-------------------------------------------------------------------------------------------+

## Partitionierung
+-----------------------------------------------------------------------------------------------------------+
|| Id  | Operation                     | Name      | Rows  | Bytes | Cost (%CPU)| Time     | Pstart| Pstop ||
|-----------------------------------------------------------------------------------------------------------|
||   0 | SELECT STATEMENT              |           |     1 |   103 |   254   (2)| 00:00:01 |       |       ||
||*  1 |  HASH JOIN ANTI               |           |     1 |   103 |   254   (2)| 00:00:01 |       |       ||
||   2 |   NESTED LOOPS                |           |    34 |  3060 |   102   (1)| 00:00:01 |       |       ||
||   3 |    NESTED LOOPS               |           |    34 |  3060 |   102   (1)| 00:00:01 |       |       ||
||   4 |     VIEW                      | VW_NSO_1  |    34 |   442 |    67   (0)| 00:00:01 |       |       ||
||   5 |      HASH UNIQUE              |           |    34 |  1496 |            |          |       |       ||
||*  6 |       HASH JOIN               |           |    34 |  1496 |    67   (0)| 00:00:01 |       |       ||
||   7 |        MERGE JOIN CARTESIAN   |           |     1 |    33 |     6   (0)| 00:00:01 |       |       ||
||*  8 |         TABLE ACCESS FULL     | ADR_TYPES |     1 |    19 |     3   (0)| 00:00:01 |       |       ||
||   9 |         BUFFER SORT           |           |     1 |    14 |     3   (0)| 00:00:01 |       |       ||
||* 10 |          TABLE ACCESS FULL    | COUNTRIES |     1 |    14 |     3   (0)| 00:00:01 |       |       ||
||  11 |        TABLE ACCESS FULL      | ADDRESSES | 23941 |   257K|    61   (0)| 00:00:01 |       |       ||
||* 12 |     INDEX UNIQUE SCAN         | CUST_PK   |     1 |       |     0   (0)| 00:00:01 |       |       ||
||  13 |    TABLE ACCESS BY INDEX ROWID| CUSTOMERS |     1 |    77 |     1   (0)| 00:00:01 |       |       ||
||  14 |   PARTITION RANGE ITERATOR    |           |   108K|  1376K|   151   (1)| 00:00:01 |  1098 |  1462 ||
||* 15 |    TABLE ACCESS FULL          | ORDERS    |   108K|  1376K|   151   (1)| 00:00:01 |  1098 |  1462 ||
|-----------------------------------------------------------------------------------------------------------|
|                                                                                                           |
|Predicate Information (identified by operation id):                                                        |
|---------------------------------------------------                                                        |
|                                                                                                           |
|   1 - access("ID"="CUST_ID")                                                                              |
|   6 - access("ATP"."ADR_TYPE"="A"."ADR_TYPE" AND "CTR"."CODE"="A"."CTR_CODE")                             |
|   8 - filter("ATP"."LABEL"='Delivery address')                                                            |
|  10 - filter("CTR"."NAME"='Switzerland')                                                                  |
|  12 - access("ID"="CUST_ID")                                                                              |
|  15 - filter("ORDER_DATE">=TO_DATE(' 2023-01-01 00:00:00', 'syyyy-mm-dd hh24:mi:ss') AND                  |
|              "ORDER_DATE"<=TO_DATE(' 2023-12-31 00:00:00', 'syyyy-mm-dd hh24:mi:ss'))                     |
+-----------------------------------------------------------------------------------------------------------+



# Query 7
## Zu Beginn  -  203ms
+-------------------------------------------------------------------------------------------------------+
|| Id  | Operation                               | Name        | Rows  | Bytes | Cost (%CPU)| Time     ||
|-------------------------------------------------------------------------------------------------------|
||   0 | SELECT STATEMENT                        |             |     1 |   106 |  1780   (1)| 00:00:01 ||
||   1 |  SORT ORDER BY                          |             |     1 |   106 |  1780   (1)| 00:00:01 ||
||   2 |   NESTED LOOPS                          |             |     1 |   106 |  1779   (1)| 00:00:01 ||
||   3 |    NESTED LOOPS                         |             |     1 |   106 |  1779   (1)| 00:00:01 ||
||   4 |     NESTED LOOPS                        |             |     1 |    77 |  1778   (1)| 00:00:01 ||
||*  5 |      HASH JOIN                          |             |     1 |    57 |  1775   (1)| 00:00:01 ||
||   6 |       NESTED LOOPS                      |             |     1 |    40 |    63   (0)| 00:00:01 ||
||   7 |        NESTED LOOPS                     |             |     2 |    40 |    63   (0)| 00:00:01 ||
||*  8 |         TABLE ACCESS FULL               | ADDRESSES   |     2 |    38 |    61   (0)| 00:00:01 ||
||*  9 |         INDEX UNIQUE SCAN               | CUST_PK     |     1 |       |     0   (0)| 00:00:01 ||
||* 10 |        TABLE ACCESS BY INDEX ROWID      | CUSTOMERS   |     1 |    21 |     1   (0)| 00:00:01 ||
||* 11 |       TABLE ACCESS FULL                 | ORDERS      |   108K|  1800K|  1711   (1)| 00:00:01 ||
||  12 |      TABLE ACCESS BY INDEX ROWID BATCHED| ORDER_ITEMS |     4 |    80 |     3   (0)| 00:00:01 ||
||* 13 |       INDEX RANGE SCAN                  | ORDI_UK     |     4 |       |     2   (0)| 00:00:01 ||
||* 14 |     INDEX UNIQUE SCAN                   | PROD_PK     |     1 |       |     0   (0)| 00:00:01 ||
||  15 |    TABLE ACCESS BY INDEX ROWID          | PRODUCTS    |     1 |    29 |     1   (0)| 00:00:01 ||
|-------------------------------------------------------------------------------------------------------|
|                                                                                                       |
|Predicate Information (identified by operation id):                                                    |
|---------------------------------------------------                                                    |
|                                                                                                       |
|   5 - access("C"."ID"="O"."CUST_ID")                                                                  |
|   8 - filter("A"."CITY"='Hogwarts' AND ("A"."ADR_TYPE"='D' OR "A"."ADR_TYPE"='DP'))                   |
|   9 - access("A"."CUST_ID"="C"."ID")                                                                  |
|  10 - filter("C"."FIRST_NAME"='Harry' AND "C"."LAST_NAME"='Potter')                                   |
|  11 - filter("O"."ORDER_DATE">=TO_DATE(' 2023-01-01 00:00:00', 'syyyy-mm-dd hh24:mi:ss'))             |
|  13 - access("I"."ORDER_ID"="O"."ID")                                                                 |
|  14 - access("P"."ID"="I"."PROD_ID")                                                                  |
+-------------------------------------------------------------------------------------------------------+

## Partition von Query 6
+-----------------------------------------------------------------------------------------------------------------------+
|| Id  | Operation                               | Name        | Rows  | Bytes | Cost (%CPU)| Time     | Pstart| Pstop ||
|-----------------------------------------------------------------------------------------------------------------------|
||   0 | SELECT STATEMENT                        |             |     1 |   108 |   220   (2)| 00:00:01 |       |       ||
||   1 |  SORT ORDER BY                          |             |     1 |   108 |   220   (2)| 00:00:01 |       |       ||
||   2 |   NESTED LOOPS                          |             |     1 |   108 |   219   (1)| 00:00:01 |       |       ||
||   3 |    NESTED LOOPS                         |             |     1 |   108 |   219   (1)| 00:00:01 |       |       ||
||   4 |     NESTED LOOPS                        |             |     1 |    79 |   218   (1)| 00:00:01 |       |       ||
||*  5 |      HASH JOIN                          |             |     1 |    59 |   215   (1)| 00:00:01 |       |       ||
||   6 |       NESTED LOOPS                      |             |     1 |    40 |    63   (0)| 00:00:01 |       |       ||
||   7 |        NESTED LOOPS                     |             |     2 |    40 |    63   (0)| 00:00:01 |       |       ||
||*  8 |         TABLE ACCESS FULL               | ADDRESSES   |     2 |    38 |    61   (0)| 00:00:01 |       |       ||
||*  9 |         INDEX UNIQUE SCAN               | CUST_PK     |     1 |       |     0   (0)| 00:00:01 |       |       ||
||* 10 |        TABLE ACCESS BY INDEX ROWID      | CUSTOMERS   |     1 |    21 |     1   (0)| 00:00:01 |       |       ||
||  11 |       PARTITION RANGE ITERATOR          |             |   108K|  2011K|   151   (1)| 00:00:01 |  1098 |1048575||
||* 12 |        TABLE ACCESS FULL                | ORDERS      |   108K|  2011K|   151   (1)| 00:00:01 |  1098 |1048575||
||  13 |      TABLE ACCESS BY INDEX ROWID BATCHED| ORDER_ITEMS |     4 |    80 |     3   (0)| 00:00:01 |       |       ||
||* 14 |       INDEX RANGE SCAN                  | ORDI_UK     |     4 |       |     2   (0)| 00:00:01 |       |       ||
||* 15 |     INDEX UNIQUE SCAN                   | PROD_PK     |     1 |       |     0   (0)| 00:00:01 |       |       ||
||  16 |    TABLE ACCESS BY INDEX ROWID          | PRODUCTS    |     1 |    29 |     1   (0)| 00:00:01 |       |       ||
|-----------------------------------------------------------------------------------------------------------------------|
|                                                                                                                       |
|Predicate Information (identified by operation id):                                                                    |
|---------------------------------------------------                                                                    |
|                                                                                                                       |
|   5 - access("C"."ID"="O"."CUST_ID")                                                                                  |
|   8 - filter("A"."CITY"='Hogwarts' AND ("A"."ADR_TYPE"='D' OR "A"."ADR_TYPE"='DP'))                                   |
|   9 - access("A"."CUST_ID"="C"."ID")                                                                                  |
|  10 - filter("C"."FIRST_NAME"='Harry' AND "C"."LAST_NAME"='Potter')                                                   |
|  12 - filter("O"."ORDER_DATE">=TO_DATE(' 2023-01-01 00:00:00', 'syyyy-mm-dd hh24:mi:ss'))                             |
|  14 - access("I"."ORDER_ID"="O"."ID")                                                                                 |
|  15 - access("P"."ID"="I"."PROD_ID")                                                                                  |
+-----------------------------------------------------------------------------------------------------------------------+

## Index auf die City angepasst
+--------------------------------------------------------------------------------------------------------------------------+
|| Id  | Operation                                  | Name        | Rows  | Bytes | Cost (%CPU)| Time     | Pstart| Pstop ||
|--------------------------------------------------------------------------------------------------------------------------|
||   0 | SELECT STATEMENT                           |             |     1 |   108 |   163   (2)| 00:00:01 |       |       ||
||   1 |  SORT ORDER BY                             |             |     1 |   108 |   163   (2)| 00:00:01 |       |       ||
||   2 |   NESTED LOOPS                             |             |     1 |   108 |   162   (2)| 00:00:01 |       |       ||
||   3 |    NESTED LOOPS                            |             |     1 |   108 |   162   (2)| 00:00:01 |       |       ||
||   4 |     NESTED LOOPS                           |             |     1 |    79 |   161   (2)| 00:00:01 |       |       ||
||*  5 |      HASH JOIN                             |             |     1 |    59 |   158   (2)| 00:00:01 |       |       ||
||   6 |       NESTED LOOPS                         |             |     1 |    40 |     6   (0)| 00:00:01 |       |       ||
||   7 |        NESTED LOOPS                        |             |     3 |    40 |     6   (0)| 00:00:01 |       |       ||
||   8 |         TABLE ACCESS BY INDEX ROWID BATCHED| CUSTOMERS   |     1 |    21 |     2   (0)| 00:00:01 |       |       ||
||*  9 |          INDEX RANGE SCAN                  | CUST_LN_FN  |     1 |       |     1   (0)| 00:00:01 |       |       ||
||* 10 |         INDEX RANGE SCAN                   | ADR_CI_ZI   |     3 |       |     1   (0)| 00:00:01 |       |       ||
||* 11 |        TABLE ACCESS BY INDEX ROWID         | ADDRESSES   |     1 |    19 |     4   (0)| 00:00:01 |       |       ||
||  12 |       PARTITION RANGE ITERATOR             |             |   108K|  2011K|   151   (1)| 00:00:01 |  1098 |1048575||
||* 13 |        TABLE ACCESS FULL                   | ORDERS      |   108K|  2011K|   151   (1)| 00:00:01 |  1098 |1048575||
||  14 |      TABLE ACCESS BY INDEX ROWID BATCHED   | ORDER_ITEMS |     4 |    80 |     3   (0)| 00:00:01 |       |       ||
||* 15 |       INDEX RANGE SCAN                     | ORDI_UK     |     4 |       |     2   (0)| 00:00:01 |       |       ||
||* 16 |     INDEX UNIQUE SCAN                      | PROD_PK     |     1 |       |     0   (0)| 00:00:01 |       |       ||
||  17 |    TABLE ACCESS BY INDEX ROWID             | PRODUCTS    |     1 |    29 |     1   (0)| 00:00:01 |       |       ||
|--------------------------------------------------------------------------------------------------------------------------|
|                                                                                                                          |
|Predicate Information (identified by operation id):                                                                       |
|---------------------------------------------------                                                                       |
|                                                                                                                          |
|   5 - access("C"."ID"="O"."CUST_ID")                                                                                     |
|   9 - access("C"."LAST_NAME"='Potter' AND "C"."FIRST_NAME"='Harry')                                                      |
|  10 - access("A"."CITY"='Hogwarts')                                                                                      |
|  11 - filter("A"."CUST_ID"="C"."ID" AND ("A"."ADR_TYPE"='D' OR "A"."ADR_TYPE"='DP'))                                     |
|  13 - filter("O"."ORDER_DATE">=TO_DATE(' 2023-01-01 00:00:00', 'syyyy-mm-dd hh24:mi:ss'))                                |
|  15 - access("I"."ORDER_ID"="O"."ID")                                                                                    |
|  16 - access("P"."ID"="I"."PROD_ID")                                                                                     |
+--------------------------------------------------------------------------------------------------------------------------+


# Query 8
## Zu Beginn  -  2s 504ms
+------------------------------------------------------------------------------------------------------+
|| Id  | Operation                      | Name        | Rows  | Bytes |TempSpc| Cost (%CPU)| Time     ||
|------------------------------------------------------------------------------------------------------|
||   0 | SELECT STATEMENT               |             |     5 |   180 |       | 25141   (1)| 00:00:01 ||
||   1 |  SORT ORDER BY                 |             |     5 |   180 |       | 25141   (1)| 00:00:01 ||
||   2 |   HASH GROUP BY                |             |     5 |   180 |       | 25141   (1)| 00:00:01 ||
||   3 |    MERGE JOIN                  |             |    72 |  2592 |       | 25139   (1)| 00:00:01 ||
||   4 |     TABLE ACCESS BY INDEX ROWID| PRODUCTS    |    72 |  1440 |       |     2   (0)| 00:00:01 ||
||   5 |      INDEX FULL SCAN           | PROD_PK     |    72 |       |       |     1   (0)| 00:00:01 ||
||*  6 |     SORT JOIN                  |             |    72 |  1152 |       | 25137   (1)| 00:00:01 ||
||   7 |      VIEW                      | VW_GBC_10   |    72 |  1152 |       | 25136   (1)| 00:00:01 ||
||   8 |       HASH GROUP BY            |             |    72 |  2232 |       | 25136   (1)| 00:00:01 ||
||*  9 |        HASH JOIN               |             |   698K|    20M|  4112K| 25118   (1)| 00:00:01 ||
||* 10 |         TABLE ACCESS FULL      | ORDERS      |   161K|  2211K|       |  1712   (1)| 00:00:01 ||
||  11 |         TABLE ACCESS FULL      | ORDER_ITEMS |  8279K|   134M|       | 11811   (1)| 00:00:01 ||
|------------------------------------------------------------------------------------------------------|
|                                                                                                      |
|Predicate Information (identified by operation id):                                                   |
|---------------------------------------------------                                                   |
|                                                                                                      |
|   6 - access("PROD"."ID"="ITEM_1")                                                                   |
|       filter("PROD"."ID"="ITEM_1")                                                                   |
|   9 - access("I"."ORDER_ID"="O"."ID")                                                                |
|  10 - filter("O"."ORDER_DATE">=TO_DATE(' 2022-01-01 00:00:00', 'syyyy-mm-dd hh24:mi:ss') AND         |
|              "O"."ORDER_DATE"<=TO_DATE(' 2022-03-31 00:00:00', 'syyyy-mm-dd hh24:mi:ss'))            |
+------------------------------------------------------------------------------------------------------+

## Partition Query 6
+-----------------------------------------------------------------------------------------------------------------------+
|| Id  | Operation                       | Name        | Rows  | Bytes |TempSpc| Cost (%CPU)| Time     | Pstart| Pstop ||
|-----------------------------------------------------------------------------------------------------------------------|
||   0 | SELECT STATEMENT                |             |     5 |   180 |       | 23653   (1)| 00:00:01 |       |       ||
||   1 |  SORT ORDER BY                  |             |     5 |   180 |       | 23653   (1)| 00:00:01 |       |       ||
||   2 |   HASH GROUP BY                 |             |     5 |   180 |       | 23653   (1)| 00:00:01 |       |       ||
||   3 |    MERGE JOIN                   |             |    72 |  2592 |       | 23651   (1)| 00:00:01 |       |       ||
||   4 |     TABLE ACCESS BY INDEX ROWID | PRODUCTS    |    72 |  1440 |       |     2   (0)| 00:00:01 |       |       ||
||   5 |      INDEX FULL SCAN            | PROD_PK     |    72 |       |       |     1   (0)| 00:00:01 |       |       ||
||*  6 |     SORT JOIN                   |             |    72 |  1152 |       | 23649   (1)| 00:00:01 |       |       ||
||   7 |      VIEW                       | VW_GBC_10   |    72 |  1152 |       | 23648   (1)| 00:00:01 |       |       ||
||   8 |       HASH GROUP BY             |             |    72 |  2232 |       | 23648   (1)| 00:00:01 |       |       ||
||*  9 |        HASH JOIN                |             |   698K|    20M|  4112K| 23630   (1)| 00:00:01 |       |       ||
||  10 |         PARTITION RANGE ITERATOR|             |   161K|  2211K|       |   224   (1)| 00:00:01 |   733 |   822 ||
||* 11 |          TABLE ACCESS FULL      | ORDERS      |   161K|  2211K|       |   224   (1)| 00:00:01 |   733 |   822 ||
||  12 |         TABLE ACCESS FULL       | ORDER_ITEMS |  8279K|   134M|       | 11811   (1)| 00:00:01 |       |       ||
|-----------------------------------------------------------------------------------------------------------------------|
|                                                                                                                       |
|Predicate Information (identified by operation id):                                                                    |
|---------------------------------------------------                                                                    |
|                                                                                                                       |
|   6 - access("PROD"."ID"="ITEM_1")                                                                                    |
|       filter("PROD"."ID"="ITEM_1")                                                                                    |
|   9 - access("I"."ORDER_ID"="O"."ID")                                                                                 |
|  11 - filter("O"."ORDER_DATE">=TO_DATE(' 2022-01-01 00:00:00', 'syyyy-mm-dd hh24:mi:ss') AND                          |
|              "O"."ORDER_DATE"<=TO_DATE(' 2022-03-31 00:00:00', 'syyyy-mm-dd hh24:mi:ss'))                             |
+-----------------------------------------------------------------------------------------------------------------------+
