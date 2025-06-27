Objective: To perform SQL-driven exploratory data analysis on football player statistics from the top 5 European leagues, aiming to extract insights related to performance, demographics, and team composition.  

Key Steps and Queries:
1.Player Distribution per Team
  Counted the number of players in each team to understand team sizes.

2. Youth Player Analysis (<21 years old)
  Identified teams with the highest number of young talents under 21.

3. Top Goal Scorers  
  Ranked players based on the total number of goals scored.

4. Top Contributors (Goals + Assists)  
  Calculated combined contributions (goals + assists) to highlight overall attacking impact.

5. Player Count by Position
  Analyzed how many players play in each position (defender, midfielder, attacker, etc.).

6. Playing Time Distribution
  Extracted players with the highest total minutes played to reflect consistent performance and manager trust.

7. Nationality Distribution  
  Identified the most represented nationalities in the leagues.

8. Ranking Players with Window Functions
  Used RANK() and DENSE_RANK() to rank players across different metrics (goals, assists, etc.), handling ties appropriately
