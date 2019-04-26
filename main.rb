require 'pry'
require 'sinatra'
require 'sinatra/reloader'
require 'httparty'

get '/' do
  erb :index
end


get '/movie' do
  @title_query = params[:title];
  @movie_data = HTTParty.get('http://omdbapi.com/?apikey=2f6435d9&plot=full&t='+ @title_query)
  erb :movie
end

get '/search' do
  @title_query = params[:query]
  @search_results = HTTParty.get('http://omdbapi.com/?apikey=2f6435d9&s='+ @title_query)

  if is_search_successful() && number_of_movies() <= 1
    @movie_data = HTTParty.get('http://omdbapi.com/?apikey=2f6435d9&plot=full&t='+ @title_query)
    erb :movie
  else
    erb :search_results
  end
end


def number_of_movies
  movie_count = 0;
  @search_results["Search"].each do |result| 
    if result["Type"] == "movie"
      movie_count += 1
    end
  end
  return movie_count
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


