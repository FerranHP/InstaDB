CREATE OR REPLACE FUNCTION func_proba_hash() 
RETURNS INT AS
$$
DECLARE
hashpos int;
capt text;
posesp  int := 0;
pos int;
posfi int;
hash text;
ishash text;
BEGIN
	select caption from posts where id=3 into capt;
	posfi = length(capt);
	WHILE posesp < posfi LOOP
		select strpos(capt,'#') into hashpos;
		select strpos(capt,' ') into posesp;
		WHILE posesp < hashpos LOOP
			select substr(capt,posesp,posfi) into capt;
			select strpos(capt,'#') into hashpos;
			select strpos(capt,' ') into pos;
			posfi = length(capt);
			IF pos = posesp THEN
				posesp = posfi;
			END IF;
		END LOOP;
		select substr(capt,hashpos,posesp) into hash;
		select hs.hashtag from hashtags hs where hs.hashtag = hash into ishash;
		IF ishash IS NULL THEN
			INSERT INTO hashtags(hashtag) VALUES (hash);
		ELSE
			UPDATE hashtags SET reps = reps+1 where hashtag=hash;
		END IF;
		posesp = posesp + 1;
		posfi = length(capt);
		select substr(capt,posesp,posfi) into capt;
		raise notice '%', hash;
	END LOOP;
	RETURN NULL;
END;
$$
language plpgsql;
