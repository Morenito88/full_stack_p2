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
	id serial primary key,
	game varchar(200),
	begin_date date
);

-- Players table (id, name, email)
CREATE TABLE players(
	id serial primary key,
	name varchar(200),
	email text
);

-- Matches table (id, tournament, winner, loser)
CREATE TABLE matches(
	id serial primary key,
	tournament_id serial references tournaments(id),
	winner_id serial references players(id),
	loser_id serial references players(id)
);

-- ************************************ --
--										--
--			      VIEWS				    --
--										--
-- ************************************ --

-- View to show the players standings (id, player, wins, matches)
CREATE VIEW players_standings AS
	SELECT
		players.id AS id,
		players.name AS name,
		wins.total_wins AS wins,
		SUM(wins.total_wins + defeats.total_loses) AS matches
	FROM
		players,
		(
			SELECT 
				players.id,
				COALESCE(COUNT(matches.loser_id), 0) AS total_loses
			FROM
				players
			LEFT OUTER JOIN 
				matches 
			ON 
				matches.loser_id = players.id
			GROUP BY
				players.id
		) AS defeats,
		(
			SELECT 
				players.id,
				COALESCE(COUNT(matches.winner_id), 0) AS total_wins
			FROM
				players
			LEFT OUTER JOIN 
				matches 
			ON 
				matches.winner_id = players.id
			GROUP BY
				players.id
		) AS wins
	WHERE
		wins.id = players.id
	AND 
		defeats.id = players.id
	GROUP BY
		players.id,
		players.name,
		wins.total_wins,
		defeats.total_loses
	ORDER BY
		wins.total_wins DESC
	;

-- ************************************ --
--										--
--			      TESTS				    --
--										--
-- ************************************ --

-- Add some data to tables for testing purposes
INSERT INTO tournaments (game, begin_date) VALUES ('League of Legends', '2015-08-31');
INSERT INTO players (name, email) VALUES ('Vilhelm Reed', 'vreed@gmail.com'), ('Meint Émile', 'emilee@gmail.com'), ('Akoni Tiryaki', 'akoko@gmail.com'), ('Amalric Alexanderson', 'kidalexx@gmail.com');
INSERT INTO matches (tournament_id, winner_id, loser_id) VALUES (1,1,3),(1,1,4),(1,1,2),(1,2,4),(1,2,3),(1,3,4);

-- View all data
SELECT * FROM tournaments;
SELECT * FROM players;
SELECT * FROM matches;
SELECT * FROM players_standings;
