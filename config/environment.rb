require 'bundler'
Bundler.require(:default, :development, :production)
ENV['SINATRA_ENV'] ||= "development"

configure :development do
  ActiveRecord::Base.establish_connection(
    :adapter => "sqlite3",
    :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
  )
end


configure :production do
  db =  URI.parse(ENV['DATABASE_URL'] || 'postgres://sraueccgerclxi:a42e0b0f73fef817f90db982b19de331ef6d13b18c05702d013c9e73a838d022@ec2-23-23-237-68.compute-1.amazonaws.com:5432/dr8vg5p9397ms')

  ActiveRecord::Base.establish_connection(
    :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
    :host     => db.host,
    :username => db.user,
    :password => db.password,
    :database => db.path[1..-1],
    :encoding => 'UTF8'
  )
end

require_relative '../app/controllers/application_controller.rb'
require_all 'app'
set :public_folder, File.dirname(__FILE__) + '/public'
