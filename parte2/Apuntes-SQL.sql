-- Crear BBDD
CREATE DATABASE twitter_db;

-- Conectarse a la BBDD
USE twitter_db;

-- CONSULTAR TABLAS
SELECT * FROM users;
SELECT * FROM followers;
SELECT * FROM tweets;
SELECT * FROM tweet_likes;

-- Creamos las tablas
CREATE TABLE users(
	user_id INT NOT NULL AUTO_INCREMENT,
    user_handle VARCHAR(50) NOT NULL UNIQUE,
    email_address VARCHAR(50) NOT NULL UNIQUE,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    phonenumber CHAR(10) UNIQUE,
    created_at TIMESTAMP NOT NULL DEFAULT (NOW()),
    PRIMARY KEY(user_id)
);

CREATE TABLE followers(
	followers_id INT NOT NULL,
	following_id INT NOT NULL,
	PRIMARY KEY(followers_id, following_id)
);

CREATE TABLE tweets(
	tweet_id INT NOT NULL AUTO_INCREMENT,
    user_id INT NOT NULL,
    tweet_text VARCHAR(280) NOT NULL,
    num_likes INT DEFAULT 0,
    num_comments INT DEFAULT 0,
    created_at TIMESTAMP NOT NULL DEFAULT (NOW()),
    FOREIGN KEY(user_id) REFERENCES users(user_id),
    PRIMARY KEY(tweet_id)
);

CREATE TABLE tweet_likes(
	user_id INT NOT NULL,
    tweet_id INT NOT NULL,
	FOREIGN KEY(user_id) REFERENCES users(user_id),
    FOREIGN KEY(tweet_id) REFERENCES tweets(tweet_id),
    PRIMARY KEY(user_id, tweet_id)
);

-- Modificamos tablas
ALTER TABLE followers ADD CONSTRAINT check_followers_id CHECK (followers_id <> following_id);

-- Insertamos datos en las tablas
INSERT INTO users (user_handle, email_address, first_name, last_name, phonenumber)
VALUES 
('vjr7', 'vinijr@realmadrid.com', 'Vinícius', 'Júnior', '6001234567'),
('bellingham5', 'jbellingham@realmadrid.com', 'Jude', 'Bellingham', '6002345678'),
('modric10', 'lmodric@realmadrid.com', 'Luka', 'Modrić', '6003456789'),
('courtois1', 'tcourtois@realmadrid.com', 'Thibaut', 'Courtois', '6004567890'),
('carvajal2', 'dcarvajal@realmadrid.com', 'Dani', 'Carvajal', '6005678901');

INSERT INTO followers(followers_id, following_id)
VALUES
(1, 2), 
(2, 1), 
(3, 1), 
(3, 6), 
(4, 1), 
(5, 2), 
(6, 3);

INSERT INTO tweets(user_id, tweet_text)
VALUES 
(1, 'Este año se viene balón de oro..'), 
(5, 'Seguro que Musiala aun sueña conmigo.'), 
(2, '@vjr7, Beach Ball!!!! xD'), 
(4, '@mbappe09, se parece a Donatello.'), 
(6, '@courtois01, Le dijo la jirafa a al tortuga...'),
(1, '@bellingham5, eso es racismo...');

INSERT INTO tweet_likes(user_id, tweet_id)
VALUES
(1, 2), 
(2, 1), 
(3, 1), 
(6, 3);

-- Sub consulta
-- Obtenemos los usuarios con mas seguidores usando JOIN para mostrar además el id de usuario, su handler y su nombre
SELECT users.user_id, users.user_handle, users.first_name, following_id, 
COUNT(followers_id) AS followers
	FROM followers
	JOIN users ON users.user_id = followers.following_id
	GROUP BY following_id
	ORDER BY followers DESC
	LIMIT 3;

-- Obtener tweets de usuarios con más de 1 seguidor
SELECT tweet_id, tweet_text, user_id
	FROM tweets
	WHERE user_id IN (
	SELECT following_id
    FROM followers
    GROUP BY following_id
    HAVING COUNT(*) > 2
);

-- Obtener número de likes de cada tweet
SELECT tweet_id, 
COUNT(*) AS like_count
	FROM tweet_likes
	GROUP BY tweet_id;

-- Borrar registro de una tabla
DELETE FROM tweets WHERE tweet_id = 2;
DELETE FROM tweets WHERE tweet_text LIKE '%jirafa%';

-- Actualizar registro de una tabla
UPDATE tweets SET tweet_text = REPLACE(tweet_text, 'jirafa', 'koala')
WHERE tweet_text LIKE '%jirafa%';

-- TRIGGERS
-- Cuando ocurre algo en la BBDD queremos que se haga alguna acción

-- TRIGGER para actualizar seguidores
DROP TRIGGER IF EXISTS increase_follower_count;

DELIMITER $$
CREATE TRIGGER increase_follower_count
	AFTER INSERT ON followers
    FOR EACH ROW
    BEGIN
		UPDATE users SET follower_count = follower_count + 1
        WHERE user_id = NEW.following_id;
    END $$
DELIMITER ;
