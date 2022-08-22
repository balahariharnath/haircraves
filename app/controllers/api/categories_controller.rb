class Api::CategoriesController < ApplicationController
  load_and_authorize_resource

  def create
    @category = Category.new(category_params.merge(user_id: current_user.id))
    if @category.save
      render json: {message: "Category Created Successfully", category: @category.as_json}, status: :created
    else
      render json: {error: @category.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def category_list
    @category = current_user.role == 'customer'? Category.all : current_user.categories
    render json: {category: @category.as_json}
  end

  private

  def category_params
    params.require(:category).permit(:category_name)
  end

end