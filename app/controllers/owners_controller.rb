class OwnersController < ApplicationController


    get '/signup' do
      if logged_in?
         redirect to "/bikes"
      else
        erb :'/owners/create_user'
      end
    end

    post "/signup" do
      owner = Owner.new(username: params[:username], password: params[:password])
      if owner.save && owner.username != ""
        session[:user_id] = owner.id
        redirect "/bikes"
      else
        redirect "/signup"
      end
    end

    get "/login" do
      if logged_in?
         redirect to "/bikes"
      else
        erb :'/owners/login'
      end
    end

    post "/login" do
      owner = Owner.find_by(username: params[:username])
      if owner && owner.authenticate(params[:password])
        session[:user_id] = owner.id
  #      binding.pry
        redirect "/bikes"
      else
        redirect "/login"
      end
    end

    get "/logout" do
      if logged_in?
        session.clear
        redirect "/login"
      else
        redirect to '/'
      end
    end

end
