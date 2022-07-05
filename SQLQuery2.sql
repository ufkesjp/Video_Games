
-- To see all of the information in the table
SELECT * 
FROM Video_Games..Game_Sales;

-- To identify all the Game Titles with muliple entries shown in the table
SELECT Name, COUNT(Name) 
FROM Video_Games..Game_Sales
GROUP BY Name
ORDER BY COUNT(Name) DESC;

--To see all of the entries with a year of release, ordered by year of release
SELECT *
FROM Video_Games..Game_Sales
WHERE Year_of_Release IS NOT NULL
ORDER BY Year_of_Release ASC;

--Top Games by Critic Scores - To see all of the entries with a critic score, ranked by critic score
SELECT DISTINCT(Name), Critic_Score
FROM Video_Games..Game_Sales
WHERE Critic_Score IS NOT NULL
ORDER BY Critic_Score DESC;

--Top Games by Sales - To see all of the entries with a year of release and global sales value, ranked by global sales
SELECT DISTINCT(Name), Year_of_Release, Genre, Publisher, Global_Sales
FROM Video_Games..Game_Sales
WHERE Year_of_Release IS NOT NULL AND Global_Sales IS NOT NULL
ORDER BY Global_Sales DESC;

--Publishers with the most global sales
SELECT Publisher, SUM(Global_Sales) AS Total_Sales
FROM Video_Games..Game_Sales
WHERE Global_Sales IS NOT NULL
GROUP BY Publisher
ORDER BY Total_Sales DESC;

--Publishers with the most releases
SELECT Publisher, COUNT(Name) AS Titles_Released
FROM Video_Games..Game_Sales
WHERE Name IS NOT NULL
GROUP BY Publisher
ORDER BY Titles_Released DESC;

--To show the # of games released per year
SELECT Year_of_Release, COUNT(Name) as Titles_Released
FROM Video_Games..Game_Sales
WHERE Year_of_Release IS NOT NULL
GROUP  BY Year_of_Release
ORDER BY Year_of_Release ASC;

--To show the # of games released per year with Genre information available
SELECT Year_of_Release, Genre, COUNT(Name) as Titles_Released
FROM Video_Games..Game_Sales
WHERE Year_of_Release IS NOT NULL AND Genre IS NOT NULL
GROUP  BY Year_of_Release, Genre
ORDER BY Year_of_Release ASC;

--To show the # of games per genre released by year 1980-2015
SELECT Year_of_Release, Genre, COUNT(Name) as Titles_Released
FROM Video_Games..Game_Sales
WHERE Year_of_Release IS NOT NULL AND Year_of_Release < 2016 AND Genre IS NOT NULL 
GROUP  BY Year_of_Release, Genre
ORDER BY Year_of_Release ASC;

--To show the # of games released per year for each platform 
SELECT Year_of_Release, Platform, COUNT(Name) as Titles_Released
FROM Video_Games..Game_Sales
WHERE Year_of_Release IS NOT NULL AND Platform IS NOT NULL
GROUP  BY Platform, Year_of_Release
ORDER BY Platform ASC;

-- To create a view showing the years in which each platform had games developed & the # of games developed for that platform each year
CREATE VIEW Platform_Lifecycle AS
SELECT Year_of_Release, Platform, COUNT(Name) as Titles_Released
FROM Video_Games..Game_Sales
WHERE Year_of_Release IS NOT NULL AND Platform IS NOT NULL
GROUP  BY Platform, Year_of_Release;

-- To query the View made above to figure out how many years each platform had games released for it
SELECT Platform, COUNT(Year_of_Release) as Years_Games_Developed
FROM Platform_Lifecycle 
WHERE Year_of_Release IS NOT NULL AND Platform IS NOT NULL
GROUP BY Platform
ORDER BY Years_Games_Developed DESC;

-- To figure out which platforms had the most game releases included in the table
SELECT Platform, SUM(Titles_Released) AS Titles_Released
FROM Platform_Lifecycle
WHERE Year_of_Release IS NOT NULL AND Platform IS NOT NULL
GROUP BY Platform
ORDER BY Titles_Released DESC;

