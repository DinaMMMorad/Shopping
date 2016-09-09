class CategoriesController < ApplicationController

  api :Get, '/categories', 'Get categories'
  param :access_token, String, desc: 'authentication token', required: true

  def index
    render json: {categories: Category.all}, status: :ok
  end

end
