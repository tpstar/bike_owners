require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get "/" do
    erb :index
  end


  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      Owner.find(session[:user_id])
    end
  end

end
