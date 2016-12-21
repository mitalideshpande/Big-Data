Create table if not exists movies
(
movie_id int,
movie_title string,
genres Array<string>)
row format delimited
fields terminated by '#'
collection items terminated by '|';


LOAD DATA LOCAL INPATH '/home/administrator/movies/movies' INTO table movies;

drop table if exists movies;

Create table if not exists ratings
(
userid int,
movieid int,
rating int,
tstamp int)
row format delimited
fields terminated by '#';

LOAD DATA LOCAL INPATH '/home/administrator/movies/ratings' INTO table ratings;

create view movies_explode as
select movie_id,movie_title,genre_type
from movies LATERAL VIEW EXPLODE(genres) mtable as genre_type;


create table list(uid int,genre_list string,avg_rating float);

insert overwrite table list select r.userid,m.genre_type,avg(r.rating) from movies_explode m join ratings r on(m.movie_id=r.movieid) group by r.userid,m.genre_type;

select uid,genre_list,avg_rating,rank() over (partition by uid order by avg_rating desc) from list limit 10;

select uid,genre_list,avg_rating from (select uid,genre_list,avg_rating,rank() over (partition by uid order by avg_rating desc) as ct from list) final where final.ct <= 5 ;

create table genre_data

(
u_id int,
m_genre_type string,
a_rating float);
INSERT OVERWRITE table genre_data select uid,genre_list,avg_rating from (select uid,genre_list,avg_rating,rank() over (partition by uid order by avg_rating desc) as ct from list) final where final.ct <= 5 ;
