class Api::ItemFavoritesController < ApplicationController
  load_and_authorize_resource

  def add_item_favourites
    @item = Item.find(params[:item_id])
    if current_user.fav_item_ids.include?(@item.id)
      current_user.fav_items.delete(@item)
      render json: {message: "Removed from favourites"}
    else
      current_user.fav_items << @item
      render json: {message: "Added to favourites"}
    end
  end

  def item_favourites
    @items = current_user.fav_items
    render json: {items: @items.as_json(methods: [:image_urls, :video_url])}
  end

  def add_service_favourites
    @stylist = User.find(params[:stylist_id])
    if current_user.fav_service_ids.include?(@stylist.id)
      current_user.fav_services.delete(@stylist)
      render json: {message: "Removed from favourites"}
    else
      current_user.fav_services << @stylist
      render json: {message: "Added to favourites"}
    end
  end


  def favourite_service_providers
    @stylists = current_user.fav_services
    render json: {service_providers: @stylists.as_json(methods: [:profile_image_url, :cover_image_url])}
  end
end
