class Api::AppointmentsController < ApplicationController
  load_and_authorize_resource

  def create_booking
    appointment = current_user.appointments.new(booking_params)
    if appointment.save
      render json: {message: "Your request has been sent successfully", appointment: appointment.as_json(include: [:services, :stylist => {methods: [:profile_image_url, :cover_image_url]}])}
    else
      render json: {message: "Appointment not saved"}
    end
  end

  def update
    appointment= Appointment.find(params[:id])
    if current_user.role == "customer"
      appointment.update(booking_params)
    else
      appointment.update(status: params[:status])
    end
    render json: {appointment: appointment.as_json(include: [:services, :stylist => {methods: [:profile_image_url, :cover_image_url]}])}
  end

  def my_bookings
    if current_user.role == 'customer'
      bookings = current_user.appointments.where("status NOT IN (?)", [3,5]) if params[:upcoming_booking].present?
      bookings = current_user.appointments.where("status IN (?)", [3,5]) if params[:completed_booking].present?
    else
      bookings = current_user.service_appointments.where("status NOT IN (?)", [3,5]) if params[:upcoming_booking].present?
      bookings = current_user.service_appointments.where("status IN (?)", [3,5]) if params[:completed_booking].present?
    end
    bookings = bookings.where("booking_date = ?", params[:date].to_date) if params[:date].present? && bookings.present?
    render json: {bookings: bookings.as_json(include: {stylist: {methods: [:profile_image_url, :cover_image_url]}, user: {methods: [:profile_image_url, :cover_image_url]}})}
  end

  def details
    render json: {appointment: @appointment.as_json(include: [:services, :stylist => {methods: [:profile_image_url, :cover_image_url], include: [:ratings]}])}
  end

  def requests
    appointments = current_user.service_appointments.where(status: 'Requested')
    render json: {appointments: appointments.as_json(include: {user: {methods: [:profile_image_url]}}) }
  end

  def rate_service_provider
    stylist = User.find(params[:stylist_id])
    if current_user.rate_user_ids.include?(stylist.id)
      render json: {message: "Already rating given"}
    else
      rate = current_user.rate_service_providers.create(rate: params[:rate], stylist_id: stylist.id)
      render json: {message: "Thank you for rating", rate: rate.as_json}
    end
  end

  private

  def booking_params
    params.require(:appointment).permit(:booking_date, :reason_for_cancel, :status, :time, :paid, :sub_total, :tax, :total,
                                        :stylist_id, :service_ids=>[])
  end
end
