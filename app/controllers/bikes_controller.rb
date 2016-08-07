#require 'rack-flash'

class BikesController < ApplicationController
  enable :sessions

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
    bike = Bike.new(name: params["name"])
    if bike.name != ""
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
    if logged_in?
     @bike = Bike.find(params[:id])
     erb :"/bikes/edit_bike"
    else
     redirect to "/login"
    end
  end

  post "/bikes/:id" do
    @bike = Bike.find(params[:id])
    @bike.name = params[:name]
    @bike.price = params[:price]
    if params[:brand_name] 
      @bike.brand = Brand.find_or_create_by(name: params["brand_name"])
    elsif params[:brands].first
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
     redirect to "/login"
    end
  end
end
