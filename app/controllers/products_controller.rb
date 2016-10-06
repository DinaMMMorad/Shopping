class ProductsController < ApplicationController

  api :Get, '/products/new', 'Get new arrival products'
  param :access_token, String, desc: 'authentication token', required: true
  param :per, String, desc: 'Number of records per page', required: false
  param :page, String, desc: 'Page Number', required: false

  def new_arrivals
    products = Product.new_arrivals.paginate(page: params[:page], per_page: params[:per])
    render json: {products: serialized_products(products)}, status: :ok
  end

  def serialized_products(products)
    ActiveModel::Serializer::CollectionSerializer.new(products, each_serializer: ProductSerializer)
  end

  api :Get, '/products', 'Get products of a selected category'
  param :access_token, String, desc: 'authentication token', required: true
  param :category, String, desc: 'product category', required: true
  param :per, String, desc: 'Number of records per page', required: false
  param :page, String, desc: 'Page Number', required: false

  def category_products
    products = Product.category_products(params[:category]).paginate(page: params[:page], per_page: params[:per])
    render json: {products: serialized_products(products)}, status: :ok
  end

  api :Get, '/search_product', 'search product with title and category'
  param :access_token, String, desc: 'authentication token', required: true
  param :category_id, String, desc: 'product category id', required: false
  param :product_title, String, desc: 'product title', required: true
  param :per, String, desc: 'Number of records per page', required: false
  param :page, String, desc: 'Page Number', required: false

  def search_product
    if params[:category_id]
      products = Product.search_product(params[:category_id], params[:product_title]).paginate(page: params[:page], per_page: params[:per])
    else #filter new arrivals
      products = Product.search_new_arrivals(params[:product_title]).paginate(page: params[:page], per_page: params[:per])
    end
    render json: {products: serialized_products(products)}, status: :ok
  end


  # api :Get, '/get_products', 'Get products by ids'
  # param :access_token, String, desc: 'authentication token', required: true
  # param :products_ids, Array, desc: 'products ids', required: true

  def get_products_by_ids
    products_ids = params[:products_ids]
    products = Array.new
    JSON.parse(products_ids).each do |product_id|
      product = Product.find_by_id(product_id)
      if product
        products.push(product)
      end
    end
    render json: {products: serialized_products(products)}, status: :ok
  end


  def change_new_arrival_state
    product_id = params['id']
    is_new_arrival = params['is_new']
    Product.find_by_id(product_id).update(:is_new => is_new_arrival)
  end

end
