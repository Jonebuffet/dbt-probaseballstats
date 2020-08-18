SELECT player_info.playerid, CONCAT(namefirst, ' ', namelast) AS "Full Name", 
       hitting_avg as "Batting Average",
	   slg_pct as "Slugging Percentage",
	   obp_stat as "On Base Percentage",
	   ops_stat as "On-base Plus Slugging Percentage"
FROM player_info
INNER JOIN player_career_stats ON player_career_stats.playerid = player_info.playerid
