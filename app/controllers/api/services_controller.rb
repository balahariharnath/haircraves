class Api::ServicesController < ApplicationController
  load_and_authorize_resource

  def service_categories
    service_category = ServiceCategory.all
    render json: {service_categories: service_category}
  end

  def create_service
    # @service = []
    # service_params[:service].each do |service|
    #
    #   @service << current_user.services.create(service)
    # end
    service = current_user.services.create(service_params)
    render json: {message: "Service created successfully", service: service}, status: :created
  end

  def edit_service
    service = Service.find(params[:id])
    service.update(service_params)
    render json: {message: "Service updated successfully", service: service}, status: :created
  end

  def destroy_service
    service = Service.find(params[:id])
    service.destroy
    render json: {data: "Service deleted successfully"}
  end

  def service_list
    user = User.find(params[:user_id])
    services = user.services
    render json: {services: services.as_json(include: {:service_category => {}})}
  end

  def profile
    user = User.find([params[:user_id]])
    render json: {user: user.as_json(methods: [:profile_image_url, :cover_image_url], include: [:portfolios => {methods: [:image_url, :video_url]},
                                               :services => {}, :items => {methods: [:image_urls, :video_url]}, :availabilities => {}])}
  end

  def service_providers
    service_providers = User.eager_load(:services).where("services.service_category_id = ?", params[:service_category_id])
    service_providers = service_providers.order('services.price desc') if params[:desc].present?
    service_providers = service_providers.order('services.price asc') if params[:asc].present?
    service_providers = service_providers.where("average_rating >= ?", params[:rating]) if params[:rating].present?
    service_providers = service_providers.where('users.id IN (?)', current_user.fav_service_ids) if params[:fav].present?
    render json: {service_providers: service_providers.as_json(methods: [:profile_image_url])}
  end

  private

  def service_params
    params.require(:service).permit(:service_category_id, :name, :price, :time)
  end
end