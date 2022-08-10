class Api::ItemsController < ApplicationController
  load_and_authorize_resource

  def create
    @item = current_user.items.new(item_params)
    if @item.save
      render json: {message: "Item created Successfully", item: @item.as_json(methods: [:image_urls, :video_url])}, status: :created
    else
      render json: {error: @item.errors.present? ? @item.errors.full_messages : "Category is not valid"}, status: :unprocessable_entity
    end
  end

  def update
    @item = Item.find(params[:id])
    @item.assign_attributes(item_params)
    if @item.save
      render json: {message: "Item Updated Successfully", item: @item.as_json(methods: [:image_urls, :video_url])}, status: 302
    else
      render json: {error: @item.errors.present? ? @item.errors.full_messages : "Category is not valid"}, status: :unprocessable_entity
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    render json: {message: "Item deleted successfully"}
  end

  def items_list
    @items = Item.where(category_id: params[:category_id]) if params[:category_id].present?
    if @items.present?
      render json: {item: @items.as_json(methods: [:image_urls, :video_url])}
    else
      render json: {error: "Category is not valid / No Items are present"}, status: :unprocessable_entity
    end
  end

  def details
    render json: {item: @item.as_json(methods: [:image_urls, :video_url], include: [:user => {methods: [:profile_image_url]}])}
  end

  private

  def item_params
    params.require(:item).permit(:category_id, :title, :description, :price, :qty, :video, :images=> [])
  end
end