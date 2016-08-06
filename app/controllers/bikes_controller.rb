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
     erb :'/bikes/new'
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
      elsif params[:brand_names].first
        bike.brand = Brand.find(params[:brand_names].first)
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
     erb :'/bikes/show'
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

  patch "/bikes/:id" do
    @bike = Bike.find(params[:id])
    if params[:content] != ""
     @bike.content = params[:content]
     @bike.save
     redirect "bikes/#{@bike.id}"
    else
     redirect "bikes/#{@bike.id}/edit"
    end
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
