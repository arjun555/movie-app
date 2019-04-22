require 'pry'
require 'sinatra'
require 'sinatra/reloader'
require 'httparty'

get '/' do
  # @result = HTTParty.get('http://omdbapi.com/?apikey=2f6435d9&t=jaws')
  
  erb :index
end


get '/movie' do
  movie = params[:title];
  # @result = HTTParty.get('http://omdbapi.com/?apikey=2f6435d9&t=jaws')
  movie_data = HTTParty.get('http://omdbapi.com/?apikey=2f6435d9&t='+ movie)
  # @result = HTTParty.get(`http://omdbapi.com/?apikey=2f6435d9&t=#{movie}`)
  # binding.pry
  @result = movie_data
  @title = movie_data["Title"]
  @year = movie_data["Year"]
  @poster = movie_data["Poster"]
  @plot = movie_data["Plot"]
  @director = movie_data["Director"]
  @actors = movie_data["Actors"]

  erb :movies
end



