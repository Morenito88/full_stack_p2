-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

-- ************************************ --
--										--
--			      TABLES				--
--										--
-- ************************************ --

-- Tournaments table (id, game, begin date)
CREATE TABLE tournaments(
	tournamentID serial primary key,
	game varchar(200),
	beginDate date
);

-- Players table (id, name, email)
CREATE TABLE players(
	playerID serial primary key,
	name varchar(200),
	email text
);

-- Matches table (id, tournament, winner, loser)
CREATE TABLE matches(
	matchID serial primary key,
	tournamentID serial references tournaments(tournamentID),
	winnerID serial references players(playerID),
	loserID serial references players(playerID)
);

-- ************************************ --
--										--
--			      VIEWS				    --
--										--
-- ************************************ --

-- View to show the players standings (id, player, wins, matches)
CREATE VIEW players_standings AS
	SELECT
		players.playerID AS id,
		players.name AS name,
		wins.totalWins AS wins,
		SUM(wins.totalWins + defeats.totalLoses) AS matches
	FROM
		players,
		(
			SELECT 
				players.playerID,
				COALESCE(COUNT(matches.loserID), 0) AS totalLoses
			FROM
				players
			LEFT OUTER JOIN 
				matches 
			ON 
				matches.loserID = players.playerID
			GROUP BY
				players.playerID
		) AS defeats,
		(
			SELECT 
				players.playerID,
				COALESCE(COUNT(matches.winnerID), 0) AS totalWins
			FROM
				players
			LEFT OUTER JOIN 
				matches 
			ON 
				matches.winnerID = players.playerID
			GROUP BY
				players.playerID
		) AS wins
	WHERE
		wins.playerID = players.playerID
	AND 
		defeats.playerID = players.playerID
	GROUP BY
		players.playerID,
		players.name,
		wins.totalWins,
		defeats.totalLoses
	ORDER BY
		wins.totalWins DESC
	;

-- ************************************ --
--										--
--			      TESTS				    --
--										--
-- ************************************ --

-- Add some data to tables for testing purposes
INSERT INTO tournaments (game, beginDate) VALUES ('League of Legends', '2015-08-31');
INSERT INTO players (name, email) VALUES ('Vilhelm Reed', 'vreed@gmail.com'), ('Meint Émile', 'emilee@gmail.com'), ('Akoni Tiryaki', 'akoko@gmail.com'), ('Amalric Alexanderson', 'kidalexx@gmail.com');
INSERT INTO matches (tournamentID, winnerID, loserID) VALUES (1,1,3),(1,1,4),(1,1,2),(1,2,4),(1,2,3),(1,3,4);

-- View all data
SELECT * FROM tournaments;
SELECT * FROM players;
SELECT * FROM matches;
SELECT * FROM players_standings;
