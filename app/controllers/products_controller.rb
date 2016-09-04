class ProductsController < ApplicationController

  api :Get, '/products/new', 'Get new arrival products'
  param :access_token, String, desc: 'authentication token', required: true

  def new_arrivals
    render json: {products: Product.new_arrivals}, status: :ok
  end

  api :Get, '/products', 'Get products of a selected category'
  param :access_token, String, desc: 'authentication token', required: true
  param :category, String, desc: 'product category', required: true

  def category_products
    render json: {products: Product.category_products(params[:category])}, status: :ok
  end

end
