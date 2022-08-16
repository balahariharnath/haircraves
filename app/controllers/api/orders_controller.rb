class Api::OrdersController < ApplicationController
  load_and_authorize_resource

  def create
    @orders = []
    params[:orders].each do |order|
      order.permit!
      @order = current_user.orders.new(order.merge(status: 'Ordered'))
      if @order.save
        @orders << @order
        current_user.cart.cart_products.destroy_all if current_user.cart.present?
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

  def my_earnings
    if params[:filter].present?
      if params[:filter] == 'week'
        @orders = current_user.seller_orders.where('created_at::DATE >= ? and created_at::DATE <= ?', Date.today.at_beginning_of_week, Date.today.at_end_of_week).group("created_at::DATE")
        @order_sold = @orders.where("created_at::DATE = ?", Date.today).sum(:grand_total)
        @order_cancelled = @orders.where("created_at::DATE = ?", Date.today).where("status = ?", 5).sum(:grand_total)

        @appointments = current_user.service_appointments.where('booking_date >= ? and booking_date <= ?', Date.today.at_beginning_of_week, Date.today.at_end_of_week).group("booking_date")
        @service_sold = @appointments.where("booking_date = ?", Date.today).sum(:total)
        @service_cancelled = @appointments.where("booking_date = ?", Date.today).where("status = ?", 3).sum(:total)
      elsif params[:filter] == 'month'
        @orders = current_user.seller_orders.where('created_at::DATE >= ? and created_at::DATE <= ?', Date.today.at_beginning_of_year, Date.today.at_end_of_year).select("date_trunc('month', created_at::DATE)").group("date_trunc('month', created_at::DATE)::DATE")
        @order_sold = @orders.where("created_at::DATE >= ? and  created_at::DATE <= ?", Date.today.at_beginning_of_month, Date.today.at_end_of_month).sum(:grand_total)
        @order_cancelled = @orders.where("created_at::DATE >= ? and  created_at::DATE <= ?", Date.today.at_beginning_of_month, Date.today.at_end_of_month).where("status = ?", 5).sum(:grand_total)

        @appointments = current_user.service_appointments.where('booking_date >= ? and booking_date <= ?', Date.today.at_beginning_of_year, Date.today.at_end_of_year).select("date_trunc('month', booking_date::DATE)").group("date_trunc('month', booking_date::DATE)::DATE")
        @service_sold = @appointments.where("booking_date >= ? and booking_date <= ?", Date.today.at_beginning_of_month, Date.today.at_end_of_month).sum(:total)
        @service_cancelled = @appointments.where("booking_date >= ? and booking_date <= ?", Date.today.at_beginning_of_month, Date.today.at_end_of_month).where("status = ?", 3).sum(:total)
      end
    else
      @orders = current_user.seller_orders
      @order_sold = @orders.sum(:grand_total)
      @order_cancelled = @orders.where(status: 5).sum(:grand_total)

      @appointments = current_user.service_appointments
      @service_sold = @appointments.sum(:total)
      @service_cancelled = @appointments.where(status: 3).sum(:total)
    end
    @orders = @orders.sum(:grand_total)
    @appointments = @appointments.sum(:total)

    if @orders.present? || @appointments.present?
      # @orders = @orders.group_by {|order| params[:filter] == 'week' ? order.created_at.to_date : order.created_at.beginning_of_month.to_date } if params[:filter].present?
      # @order_total = @order_sold - @order_cancelled
      render json: {data: {orders: @orders, appointments: @appointments, order_sold: @order_sold, order_cancelled: @order_cancelled, service_sold: @service_sold, service_cancelled: @service_cancelled}}
    else
      render json: {data: nil}
    end
  end
end
