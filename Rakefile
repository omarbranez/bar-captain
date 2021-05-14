ENV["SINATRA_ENV"] ||= "development"

require_relative './config/environment'
require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'


task :console do
  Pry.start
end

task :seed do
  rake db:seed
end