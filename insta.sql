--
-- PostgreSQL database dump
--

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    password character varying(128) NOT NULL,
    last_login timestamp ,
    is_superuser boolean NOT NULL,
    username character varying(30) UNIQUE NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(30) NOT NULL,
    email character varying(254) NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp  NOT NULL
);

--insert into users values (1,'xdesxqa0','2016-09-12',False,'irvi','ferran','homet','ferran@gmail.com',True,'2016-09-12');

CREATE TABLE posts (
    id SERIAL PRIMARY KEY,
    timestamp timestamp  NOT NULL,
    modified timestamp  NOT NULL,
    image character varying(100) NOT NULL,
    caption text NOT NULL,
    phone_type character varying(30) NOT NULL,
    time_last_click timestamp  NOT NULL,
    is_processed boolean NOT NULL,
    is_private boolean NOT NULL,
    owner_id bigint NOT NULL,
    is_deleted boolean NOT NULL
);

--insert into posts values ( 1,'2016-09-12','2016-09-12','/var/tmp','hey!','+34678106143','2016-09-12',True,False,1,False);

--
ALTER TABLE posts
    ADD FOREIGN KEY (owner_id) REFERENCES users(id);
--
--
-- Name: comments; Type: TABLE; Schema: public; Owner: isx47167139; Tablespace: 
--

CREATE TABLE comments (
    id SERIAL PRIMARY KEY,
    timestamp timestamp  NOT NULL,
    modified timestamp  NOT NULL,
    comment text NOT NULL,
    owner_id bigint NOT NULL,
    post_id bigint NOT NULL
);

ALTER TABLE comments
    ADD FOREIGN KEY (owner_id) REFERENCES users(id);

ALTER TABLE comments
    ADD FOREIGN KEY (post_id) REFERENCES posts(id);

CREATE TABLE likes (
    id SERIAL PRIMARY KEY,
    timestamp timestamp  NOT NULL,
    owner_id bigint NOT NULL,
    post_id bigint NOT NULL,
    is_deleted boolean NOT NULL,
    UNIQUE (owner_id,post_id)  
);

ALTER TABLE likes
    ADD FOREIGN KEY (owner_id) REFERENCES users(id);

ALTER TABLE likes
    ADD FOREIGN KEY (post_id) REFERENCES posts(id);

CREATE TABLE followers (
    id SERIAL PRIMARY KEY,
    timestamp timestamp  NOT NULL,
    is_confirmed boolean NOT NULL,
    followed_by_id bigint NOT NULL,
    follows_id bigint NOT NULL,
    UNIQUE(follows_id,followed_by_id)
);

ALTER TABLE followers
    ADD FOREIGN KEY (followed_by_id) REFERENCES users(id);
    
ALTER TABLE followers
    ADD FOREIGN KEY (follows_id) REFERENCES users(id);

CREATE TABLE hashtags (
	id SERIAL PRIMARY KEY,
	hashtag character varying(128) NOT NULL,
	reps int DEFAULT 0
);

CREATE TABLE comtohash (
	id SERIAL PRIMARY KEY,
	com_id bigint NOT NULL,
	hash_id bigint NOT NULL,
	UNIQUE (com_id, hash_id)
);

ALTER TABLE comtohash
	ADD FOREIGN KEY (com_id) REFERENCES comments(id);
	
ALTER TABLE comtohash
	ADD FOREIGN KEY (hash_id) REFERENCES hashtags(id);
	
CREATE TABLE postohash (
	id SERIAL PRIMARY KEY,
	post_id bigint NOT NULL,
	hash_id bigint NOT NULL,
	UNIQUE (post_id, hash_id)
);

ALTER TABLE postohash
	ADD FOREIGN KEY (post_id) REFERENCES posts(id);
	
ALTER TABLE postohash
	ADD FOREIGN KEY (hash_id) REFERENCES hashtags(id);
