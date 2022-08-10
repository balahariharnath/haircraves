class Api::CartsController < ApplicationController
  load_and_authorize_resource

  def create
    @cart = current_user.cart.present? ? current_user.cart : Cart.create(user_id: current_user.id)
    @cart.cart_products.create(cart_products_params)
    render json: {cart: @cart}
  end

  # def update_qty
  #   @cart_product = CartProduct.find(params[:cart_product_id])
  #   @cart_product.update(qty: params[:qty])
  #
  #   render json: {cart_products: @cart_product.as_json(include: :cart)}
  # end

  def cart_list
    @cart = current_user.cart
    render json: {cart: @cart.as_json(include: {cart_products: {include: {item: {methods: [:image_urls, :video_url]}}}})}
  end

  def remove_item
    @cart = Cart.find(params[:id])
    @item = Item.find(params[:item_id])
    @cart.items.destroy(@item)
    render json: {cart: @cart.as_json(include: {cart_products: {include: {item: {methods: [:image_urls, :video_url]}}}})}
  end

  private

  def cart_products_params
    params.require(:cart_products).permit(:qty, :item_id)
  end
end