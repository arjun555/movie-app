require 'pry'
require 'sinatra'
require 'sinatra/reloader'
require 'httparty'

get '/' do
  erb :index
end


get '/movie' do
  movie = params[:title];
  # @result = HTTParty.get('http://omdbapi.com/?apikey=2f6435d9&t=jaws')
  @movie_data = HTTParty.get('http://omdbapi.com/?apikey=2f6435d9&t='+ movie)
  # @result = movie_data
  # @title = movie_data["Title"]
  # @year = movie_data["Year"]
  # @rated = movie_data["Rated"]
  # @runtime = movie_data["Runtime"]
  # @genre = movie_data["Genre"]
  # @poster = movie_data["Poster"]
  # @plot = movie_data["Plot"]
  # @director = movie_data["Director"]
  # @actors = movie_data["Actors"]

  erb :movies
end




