require 'pg'
require 'active_record'

options = {
  adapter: 'postgresql',
  database: 'movies_app'
}

ActiveRecord::Base.establish_connection(options)