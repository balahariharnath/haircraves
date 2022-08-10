class Api::AvailabilitiesController < ApplicationController
  load_and_authorize_resource

  def availability_list
    @availability = current_user.availabilities

    render json: {availabilities: @availability}
  end

  def update_availability
    @availability = Availability.find(params[:id])
    if @availability.update(availability_params)
      render json: {availability: @availability}
    else
      render json: {error: @availability.errors.full_messages}
    end
  end

  private

  def availability_params
    params.require(:availability).permit(:start_time, :end_time, :active)
  end
end
