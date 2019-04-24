require 'pry'
require 'sinatra'
require 'sinatra/reloader'
require 'httparty'

get '/' do
  erb :index
end


get '/movie' do
  movie = params[:title];
  puts "movie = #{movie}"
  # @movie_data = HTTParty.get('http://omdbapi.com/?apikey=2f6435d9&t=Jaws')
  @movie_data = HTTParty.get('http://omdbapi.com/?apikey=2f6435d9&t='+ movie)
  # @movie_data = HTTParty.get('http://omdbapi.com/?apikey=2f6435d9&plot=full&s='+ movie)
  erb :movie
end

get '/search' do
  title_query = params[:query]
  @search_results = HTTParty.get('http://omdbapi.com/?apikey=2f6435d9&s='+ title_query)
  erb :search_results
end



