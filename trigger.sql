-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
-- 							trigger post_hash  
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
CREATE OR REPLACE FUNCTION func_hash_post() 
RETURNS TRIGGER AS
$$
DECLARE
hash text := '';

BEGIN
	select hashtag from hashtags hs where hs.hashtag = NEW.hashtag into hash;
	IF hash IS NULL THEN
		INSERT INTO hashtags(hashtag) VALUES (NEW.hashtag);
	ELSE
		UPDATE hashtags SET reps = reps+1 where hashtag=NEW.hashtag;
	END IF;
	RETURN NEW;
END;
$$
language plpgsql;

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
CREATE TRIGGER tri_hash_post BEFORE INSERT OR UPDATE ON postohash
FOR EACH ROW EXECUTE PROCEDURE func_hash_post();

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
-- 							trigger com_hash
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
CREATE OR REPLACE FUNCTION func_hash_com() 
RETURNS TRIGGER AS
$$
DECLARE
hash text := '';

BEGIN
	select hashtag from hashtags hs where hs.hashtag = NEW.hashtag into hash;
	IF hash IS NULL THEN
		INSERT INTO hashtags(hashtag) VALUES (NEW.hashtag);
	ELSE
		UPDATE hashtags SET reps = reps+1 where hashtag=NEW.hashtag;
	END IF;
	RETURN NEW;
END;
$$
language plpgsql;

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
CREATE TRIGGER tri_hash_com BEFORE INSERT OR UPDATE ON comtohash
FOR EACH ROW EXECUTE PROCEDURE func_hash_com();
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
