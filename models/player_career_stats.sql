{{ config(materialized='table') }}
SELECT  playerid,
        ROUND(CAST(SUM(hits) as decimal)/CAST(SUM(ab) as decimal), 3) as hitting_avg,
	ROUND(CAST(((((SUM(hits) - SUM(doubles)) - SUM(triples)) - SUM(hr)) + (2 * SUM(doubles)) + (3 * SUM(triples)) + (4 * SUM(hr))) as decimal)/CAST(SUM(AB) as decimal) ,3) as slg_pct,
	ROUND(CAST(SUM(hits) + SUM(bb) + SUM(hbp) as decimal)/CAST((SUM(ab) + SUM(bb) + SUM(hbp) + SUM(sf)) as decimal), 3) as obp_stat,
	ROUND(CAST(SUM(hits) + SUM(bb) + SUM(hbp) as decimal)/CAST((SUM(ab) + SUM(bb) + SUM(hbp) + SUM(sf)) as decimal), 3) + 
	ROUND(CAST(((((SUM(hits) - SUM(doubles)) - SUM(triples)) - SUM(hr)) + (2 * SUM(doubles)) + (3 * SUM(triples)) + (4 * SUM(hr))) as decimal)/CAST(SUM(AB) as decimal) ,3) as ops_stat
FROM player_batting_by_year
WHERE playerid IN (SELECT playerid
		   FROM player_batting_by_year
		   GROUP BY playerid
		   HAVING SUM(ab) > 0)
GROUP BY playerid
