SELECT * FROM dbo.netflix;

--Query to select only 5 row
SELECT  TOP 5 * FROM dbo.netflix;

--Query to select Distinct showid from netflix
SELECT DISTINCT show_id FROM dbo.netflix;

--Query to select distinct title where release year is greater than 2020
SELECT DISTINCT title FROM dbo.netflix
WHERE release_year>2020;

--Query SELECT,AND,OR,NOT
SELECT DISTINCT title FROM dbo.netflix
WHERE release_year>2020 AND  title='A perfect fit'
OR release_year<2021 and title='kota Factory'
AND NOT country ='India';

-- Query order by
SELECT DISTINCT title AS "Name" FROM dbo.netflix
ORDER BY Name

--Query Aggregation(SUM,AVG,MIN,MAX,COUNT)
SELECT MAX(release_year) FROM dbo.netflix;
SELECT MIN(release_year) FROM dbo.netflix;
SELECT COUNT(DISTINCT release_year) FROM dbo.netflix;
SELECT ROUND(AVG(release_year),0) FROM dbo.netflix;
SELECT SUM(release_year) FROM dbo.netflix;

--Query LIKE
SELECT DISTINCT country FROM dbo.netflix 
WHERE country LIKE '%a' OR country LIKE '%n';

SELECT title FROM dbo.netflix
WHERE title LIKE '__j%';

SELECT title FROM dbo.netflix
WHERE title LIKE '%y';

--Query IN 
SELECT * FROM dbo.netflix
WHERE country IN('India','Australia','london')
ORDER BY country DESC;

--Query BETWEEN
SELECT * FROM dbo.netflix
WHERE release_year BETWEEN 2020 AND 2021;

--Query CASE 
SELECT SUM(case when country ='India' then 1 else 0 end) AS show_in_India FROM dbo.netflix;
SELECT COUNT(case when country='United states' then 1 else 0 end) AS show_in_Unitedstates FROM dbo.netflix;
SELECT SUM(case when title ='Midnight Mass' then 1 else 0 end) AS showname FROM dbo.netflix;

--Query CAST
SELECT CAST(release_year as float) AS "non_zero_value" FROM dbo.netflix;

--Query led/lag
SELECT title,release_year,
CASE when release_year=LAG(release_year)OVER(ORDER BY release_year ASC)
then 1 
else 0
end
as back_to_back FROM dbo.netflix
ORDER BY release_year;

--Query ROW NUMBER 
SELECT title,ROW_NUMBER()OVER(ORDER BY title ASC) AS "ROW_NUMBER"
FROM dbo.netflix
GROUP BY title
ORDER BY title ASC;

--Query JOIN
SELECT a.title,a.country,b.role 
FROM dbo.netflix a
INNER JOIN title b
ON a.show_id=b.id

--Query WITH
SELECT a.value FROM (SELECT DISTINCT 'country that end with a ' country
DENSE_RANK()OVER(ORDER BY country ASC )as rank FROM netflix 
WHERE country LIKE '%a'
)a
WHERE rank=1
UNION ALL
SELECT a.value FROM
( SELECT  DISTINCT'country that starts with a:'country 
DENSE_RANK()OVER(ORDER BY country ASC) as rank FROM dbo.netflix
WHERE country LIKE'a%'
)a
WHERE rank=1
UNION ALL
SELECT a.value FROM(
SELECT DISTINCT 'Country that has a and minimum length 4:'||country as value,
DENSE_RANK()OVER(ORDER BY country ASC )as rank FROM dbo.netflix
WHERE country LIKE'a_ _%'
)a
WHERE rank=1

--Query with
with b as
(SELECT a.country,a.show_id,row_number()over(order by a.show_id desc)as rank
FROM
(
SELECT count(DISTINCT title) as shows_id,country 
FROM dbo.netflix
group by country)a
)
SELECT country as country_most_show FROM b
WHERE b.rank=1









