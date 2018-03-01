/* SQL 1 */
/* Assuming that the inserted relationship is bi-directional, person1 and person2 */
WITH temptable AS (SELECT t1.person1, t1.person2 FROM connections t1 UNION ALL SELECT t2.person2, t2.person1 FROM connections t2 )
SELECT
	person1
    ,count(person2)
FROM
	temptable
GROUP BY
	person1
ORDER BY
	count(*) desc;
	
   
    
/* SQL 2 */
WITH temptable AS (SELECT t1.person1, t1.person2 FROM connections t1 UNION ALL SELECT t2.person2, t2.person1 FROM connections t2 )
SELECT 
	person1
FROM
(SELECT
	t1.person1
    ,count(t1.person2)
    ,DENSE_RANK() OVER (ORDER BY COUNT(t1.person2) desc) as ranking
FROM
	temptable t1

    JOIN
(SELECT
	person2
FROM 
	temptable 
WHERE
	person1 = 'Meg Bush') filts
    ON filts.person2 = t1.person2
    AND t1.person1 != 'Meg Bush'
GROUP BY 
	t1.person1) tilt
WHERE ranking = 1;

/* SQL 3 */
WITH temptable AS (SELECT t1.person1, t1.person2 FROM connections t1 UNION ALL SELECT t2.person2, t2.person1 FROM connections t2 )
SELECT
	t1.person1 PrimaryP1
    /* ,t1.person2 ConnectingPerson */ 
    ,count(t1.person2) as CommonConnections
    ,t2.person2 PrimaryP2
FROM
	temptable t1 JOIN 
    temptable t2 ON t1.person2 = t2.person1
WHERE
	t1.person1 != t2.person2
    /* Remove below filter to find all of the common connections */
   	AND t1.person1 in ('Jeb Bush') /* Filters out person1 to find connection  */
    AND t2.person2 in ('Meg Bush') /* Filters out person2 to find connection */
GROUP BY
	primaryp1
    ,primaryp2;
	

/* 4 & 5 

SQL would be able to still do it, if we had stored procedures running to aggregate the tables. 10M is still something (that maybe will be a cost lookup for connections)
however, we would be exchanging time, off-time to perform the aggregation and would probably not be done on-demand.
If we needed it real-time, we would either need a stronger/faster processing computating (i.e. Spark.. maybe Hadoop).
Or we would utilize a combination of a graph database with spark if we were to really only care about the relationships (i.e. connections), adn we needed it immediately.

There is an additional trade-off in that postgres is more familiar given its a SQL database, versus switching completely to a noSQL graph DB, or big data that will require more configuration and setup
NoSQL recommendation would be either Graph DB (given its all connections), and mxiture of Spark for faster compute as it will be done in memory. If the business use case is required then it
may also make sense to utilize that
*/





	