class ProductsController < ApplicationController

  api :Get, '/products/new', 'Get new arrival products'
  param :access_token, String, desc: 'authentication token', required: true

  def new_arrivals
    products = Product.new_arrivals
    render json: {products: serialized_products(products)}, status: :ok
  end

  def serialized_products(products)
    ActiveModel::Serializer::CollectionSerializer.new(products, each_serializer: ProductSerializer)
  end

  api :Get, '/products', 'Get products of a selected category'
  param :access_token, String, desc: 'authentication token', required: true
  param :category, String, desc: 'product category', required: true

  def category_products
    render json: {products: Product.category_products(params[:category])}, status: :ok
  end


  # api :Get, '/get_products', 'Get products by ids'
  # param :access_token, String, desc: 'authentication token', required: true
  # param :products_ids, Array, desc: 'products ids', required: true

  def get_products_by_ids
    products_ids = params[:products_ids]
    products = Array.new
    JSON.parse(products_ids).each do |product_id|
      products.push(Product.find_by_id(product_id))
    end
    render json: {products: serialized_products(products)}, status: :ok
  end


  def change_new_arrival_state
    product_id = params['id']
    is_new_arrival = params['is_new']
    Product.find_by_id(product_id).update(:is_new => is_new_arrival)
  end

end
