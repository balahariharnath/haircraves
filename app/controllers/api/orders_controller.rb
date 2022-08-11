class Api::OrdersController < ApplicationController
  load_and_authorize_resource

  def item_rating
    @item = Item.find(params[:item_id])
    if current_user.rated_item_ids.include?(@item.id)
      render json: {message: "Already rating given"}
    else
      @rate = current_user.item_ratings.create(rate: params[:rate], item_id: @item.id)
      render json: {message: "Thank you for rating", rate: @rate.as_json}
    end
  end
end
