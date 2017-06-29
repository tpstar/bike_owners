class BrandsController < ApplicationController
  get "/brands" do
    if logged_in?
      @brands = Brand.all
      erb :"/brands/brands"
    else
     session[:login_warning] = "Please login first."
     redirect to "/login"
    end
  end

  get "/brands/:id" do
    if logged_in?
     @brand = Brand.find(params[:id])
     erb :'/brands/show_brand'
    else
     session[:login_warning] = "Please login first."
     redirect to "/login"
    end
  end
end
