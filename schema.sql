CREATE DATABASE movies_app;

CREATE TABLE movies(
    id SERIAL PRIMARY KEY,
    imdb_id TEXT,
    title TEXT,
    release_year INTEGER,
    poster TEXT,
    rated TEXT,
    runtime TEXT,
    genre TEXT,
    plot TEXT,
    director TEXT,
    actors TEXT
);