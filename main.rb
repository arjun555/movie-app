require 'pry'
require 'sinatra'
require 'sinatra/reloader'
require 'httparty'
require_relative 'db_config'
require_relative 'models/movie'

get '/' do
  erb :index
end

get '/movie' do
  @title_movie = params[:title];
  if is_movie_cached()
    puts "#{@title_movie} movie is cached!"
    @movie_data = HTTParty.get('http://omdbapi.com/?apikey=2f6435d9&plot=full&t='+ @title_movie)
  else
    puts "#{@title_movie} movie is not cached!"
    @movie_data = HTTParty.get('http://omdbapi.com/?apikey=2f6435d9&plot=full&t='+ @title_movie)
  end
  add_movie_cache()
  erb :movie
end

get '/search' do
  @title_query = params[:query]
  @search_results = HTTParty.get('http://omdbapi.com/?apikey=2f6435d9&s='+ @title_query)
  get_movie_results()
  if is_search_successful() && @movie_results.length <= 1
    redirect "/movie?title=#{@title_query}"
  else
    erb :search_results
  end
end


def add_movie_cache
  movie = Movie.new
  movie.imdb_id = @movie_data["imdbID"]
  movie.title = @movie_data["Title"]
  movie.release_year = @movie_data["Year"]
  # movie.type = @movie_data["Type"]
  movie.poster = @movie_data["Poster"]
  movie.save
end

def is_movie_cached
  movies = Movie.where(title: @title_movie)
  if movies.length > 0 
    return true
  else
    return false
  end
end

def get_movie_results
  @movie_results = []
  @search_results["Search"].each do |result| 
    if result["Type"] == "movie"
      @movie_results.push(result)
    end
  end
  return @movie_results
end

def is_search_successful
  if @search_results["Response"] == "True"
    @search_successful = true
    return true
  else
    @search_successful = false
    return false
  end
end