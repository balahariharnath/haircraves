class Api::AppointmentsController < ApplicationController
  load_and_authorize_resource

  def create_booking
    @appointment = current_user.appointments.new(booking_params.merge(status: 0))
    if @appointment.save
      render json: {appointment: @appointment.as_json(include: [:services, :stylist => {methods: [:profile_image_url, :cover_image_url]}])}
    else
      render json: {message: "Appointment not saved"}
    end
  end

  def update
    @appointment= Appointment.find(params[:id])
    if current_user.role.role_name == "customer"
      @appointment.update(booking_params)
    else
      @appointment.update(status: params[:status])
    end
    render json: {appointment: @appointment.as_json(include: [:services, :stylist => {methods: [:profile_image_url, :cover_image_url]}])}
  end

  private

  def booking_params
    params.require(:appointment).permit(:booking_date, :reason_for_cancel, :status, :time, :paid, :sub_total, :tax, :total,
                                        :stylist_id, :service_ids=>[])
  end
end
