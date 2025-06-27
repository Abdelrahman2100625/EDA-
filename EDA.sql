SELECT 
    COLUMN_NAME, 
    DATA_TYPE, 
    CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'football player 24/25';

select * from [football player 24/25];

--  1. top player building attack in each league
with Ranked as (
	select
		player,
		comp,
		sum(Prgc+PrgR) as progression,
		rank() over(partition by comp order by sum(Prgc+Prgr) desc ) as PlayerRank
		from [football player 24/25]
		group by player , comp
	)
	
select player , comp , progression 
from ranked
where Playerrank = 1 
order by progression desc;
--------------------------------------------------------------------------------------------------------------

--  2.  Who is the top goal scorer in each team?

with scorer as (
	select 
		player,	
		Squad as team,
		gls as goals,
		rank() over(partition by squad order by gls desc) as rn
from [football player 24/25]
)
select player , team , goals , rn
from scorer
where rn = 1
order by goals desc;
----------------------------------------------------------------------------------------------------------
-- 3.  Which 5 teams have the highest total number of goals scored by their players?

select top(5) Squad as team , sum(gls) as goals 
from [football player 24/25]
group by Squad
order by goals desc;

-------------------------------------------------------------------------------------------------------------
-- 4. List all players whose expected goals (xG) are higher than their actual goals scored.

select Player , gls , xG 
from [football player 24/25]
where xg > gls;

-------------------------------------------------------------------------------------------------------------
-- 5.  Which players have the highest assists per 90 minutes?
select Player , (Ast * 90) / [Min] as [Ast per match]
from [football player 24/25]
order by [Ast per match] desc;

-------------------------------------------------------------------------------------------------------------
-- 6. What is the average age of players in each team?
select Squad as Team , avg(age) as AVG_Age
from [football player 24/25]
group by Squad
order by AVG_Age ;

-------------------------------------------------------------------------------------------------------------
/* 7.Find all players who have:
- more than 5 goals
- more than 3 assists
- have played more than 1000 minutes */

select Player , gls as goals , ast as assist , [min] as minute_played
from [football player 24/25]
where 
	gls > 5 and ast > 3 and [min] > 1000
order by goals desc , assist desc , minute_played desc;

-------------------------------------------------------------------------------------------------------------
-- 8.  Who is the youngest player to score at least one goal?
select Player , age , gls as goal
from [football player 24/25]
where gls >= 1 and age is not null
order by age ;

-------------------------------------------------------------------------------------------------------------
-- 9.What percentage of players under the age of 21 are there in each team?
select 
	squad as team , 
	format(COUNT(case when age < 21 then 1 end) *1.0 / count(*) ,'n2')as under21_percentage
from [football player 24/25]
where age is not null
group by squad
order by COUNT(case when age < 21 then 1 end) *1.0 / count(*) desc;

-------------------------------------------------------------------------------------------------------------
-- 10. Rank each player within their team based on total goals scored.
select	
	player, 
	squad,
	gls,
	dense_rank() over(partition by squad order by gls desc) as rn
from [football player 24/25];

-------------------------------------------------------------------------------------------------------------
-- 11. Retrieve the second highest goals for each compotetion.
with goals as(
select 
	comp, 
	sum(gls) as total_goals 
from [football player 24/25] 
group by comp
)

select comp , total_goals
from goals
where total_goals < (Select max(total_goals) from goals)
order by total_goals desc
Offset 0 rows fetch next 1 rows only

-------------------------------------------------------------------------------------------------------------

