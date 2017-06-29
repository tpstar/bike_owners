class BrandsController < ApplicationController
  get "/brands" do
    if logged_in?
      @brands = Brand.all
      erb :"/brands/brands"
    else
     redirect to "/login"
    end
  end

  get "/brands/:id" do
    if logged_in?
     @brand = Brand.find(params[:id])
     erb :'/brands/show_brand'
    else
     redirect to "/login"
    end
  end
end
