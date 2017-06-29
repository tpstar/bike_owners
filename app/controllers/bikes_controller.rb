class BikesController < ApplicationController
  enable :sessions
  use Rack::Flash

  get "/bikes" do
    if logged_in?
      @bikes = Bike.all
      erb :'/bikes/bikes'
    else
      redirect to "/login"
    end
  end

  get '/bikes/new' do
    if logged_in?
      erb :'/bikes/new_bike'
    else
      redirect to "/login"
    end
  end

  post "/bikes" do
    if params["name"] != ""
      bike = Bike.new(name: params["name"])
      bike.owner_id = current_user.id
      bike.price = params["price"]
      bike.review = params["review"]
      if !params[:brand_name].empty?
        bike.brand = Brand.find_or_create_by(name: params["brand_name"])
      elsif params[:brands].first
        bike.brand = Brand.find(params[:brands].first)
      end
      bike.save
      redirect to "/bikes"
    else
      flash[:warning] = "Please enter bike's name."
      redirect to "/bikes/new"
    end
  end

  get "/bikes/:id" do
    if logged_in?
     @bike = Bike.find(params[:id])
     erb :'/bikes/show_bike'
    else
     redirect to "/login"
    end
  end

  get "/bikes/:id/edit" do
    @bike = Bike.find(params[:id])
    if logged_in?
      if current_user == @bike.owner
        erb :"/bikes/edit_bike"
      else
        flash[:warning] = "You are not allowed to edit other user's bike information."
        redirect "bikes/#{@bike.id}"
      end
    else
      redirect to "/login"
    end
  end

  patch "/bikes/:id" do
    @bike = Bike.find(params[:id])
    @bike.name = params[:name]
    @bike.price = params[:price]
    @bike.review = params[:review]
    if params[:brand_name]
      @bike.brand = Brand.find_or_create_by(name: params["brand_name"])
    elsif params[:brands]
      @bike.brand = Brand.find(params[:brands].first)
    end
    @bike.save
    redirect "bikes/#{@bike.id}"
  end


  delete '/bikes/:id/delete' do
    @bike = Bike.find(params[:id])
    if current_user == @bike.owner
      @bike = Bike.find(params[:id])
      @bike.delete
      redirect to '/bikes'
    else
      flash[:warning] = "You are not allowed to delete other user's bike information."
      redirect to "bikes/#{@bike.id}"
    end
  end
end
