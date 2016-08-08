class OwnersController < ApplicationController
    enable :sessions
    use Rack::Flash

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

    get "/owners" do
      if logged_in?
        @owners = Owner.all
        erb :"/owners/owners"
      end
    end

    get "/owners/:id" do
      if logged_in?
       @owner = Owner.find(params[:id])
       erb :'/owners/show_owner'
      else
       redirect to "/login"
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
