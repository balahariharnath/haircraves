class Api::OrdersController < ApplicationController
  load_and_authorize_resource

  def create
    @orders = []
    params[:orders].each do |order|
      order.permit!
      @order = current_user.orders.new(order.merge(status: 'Ordered'))
      if @order.save
        @orders << @order
        current_user.cart.cart_products.destroy_all
      else
        return render json: {error: @order.errors.full_messages}, status: :unprocessable_entity
      end
    end
    render json: {message: "your order has been placed successfully", orders: @orders.as_json(include: {:seller => {methods: [:profile_image_url]},
                               :address=> {}, :item => {methods: [:image_urls, :video_url]}})}, status: :created
  end

  def update
    @order.update(status: params[:status])
    render json: {message: "Order status updated"}, status: :found
  end

  def order_status
    @status = ['Ordered', 'Packed', 'Shipped', 'On the way', 'Delivered', 'Cancelled', 'Returned']
    render json: {status: @status.as_json}
  end

  def my_orders
    if current_user.role.role_name == "customer"
      @orders = current_user.orders
      render json: {orders: @orders.as_json(include: {:seller => {methods: [:profile_image_url]}, :address=> {},
                                                    :item => {methods: [:image_urls, :video_url], include: [:item_ratings]}})}
    else
      @orders = current_user.seller_orders
      render json: {orders: @orders.as_json(include: {:user => {methods: [:profile_image_url]}, :address=> {},
                                                      :item => {methods: [:image_urls, :video_url], include: [:item_ratings]}})}
    end
  end

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
