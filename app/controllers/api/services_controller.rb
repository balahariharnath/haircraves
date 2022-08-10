class Api::ServicesController < ApplicationController
  load_and_authorize_resource

  def service_categories
    @service_category = current_user.service_categories
    render json: {service_categories: @service_category}
  end

  def create_service
    # @service = []
    # service_params[:service].each do |service|
    #
    #   @service << current_user.services.create(service)
    # end
    @service = current_user.services.create(service_params)
    render json: {message: "Service created successfully", service: @service}, status: :created
  end

  def edit_service
    @service = Service.find(params[:id])
    @service.update(service_params)
    render json: {message: "Service updated successfully", service: @service}, status: :created
  end

  def destroy_service
    @service = Service.find(params[:id])
    @service.destroy
    render json: {data: "Service deleted successfully"}
  end

  def service_list
    user = User.find(params[:user_id])
    @services = user.services
    render json: {services: @services.as_json(include: {:service_category => {}})}
  end

  def profile
    @user = User.find([params[:user_id]])
    render json: {user: @user.as_json(methods: [:profile_image_url, :cover_image_url], include: [:portfolio => {methods: [:image_url, :video_url]},
                                               :services => {}, :items => {methods: [:image_urls, :video_url]}, :availabilities => {}])}
  end

  private

  def service_params
    params.require(:service).permit(:service_category_id, :name, :price, :time)
  end
end