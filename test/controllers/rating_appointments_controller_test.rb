require "test_helper"

class RatingAppointmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rating_appointment = rating_appointments(:one)
  end

  test "should get index" do
    get rating_appointments_url
    assert_response :success
  end

  test "should get new" do
    get new_rating_appointment_url
    assert_response :success
  end

  test "should create rating_appointment" do
    assert_difference("RatingAppointment.count") do
      post rating_appointments_url, params: { rating_appointment: { appointment_id: @rating_appointment.appointment_id, rate: @rating_appointment.rate, user_id: @rating_appointment.user_id } }
    end

    assert_redirected_to rating_appointment_url(RatingAppointment.last)
  end

  test "should show rating_appointment" do
    get rating_appointment_url(@rating_appointment)
    assert_response :success
  end

  test "should get edit" do
    get edit_rating_appointment_url(@rating_appointment)
    assert_response :success
  end

  test "should update rating_appointment" do
    patch rating_appointment_url(@rating_appointment), params: { rating_appointment: { appointment_id: @rating_appointment.appointment_id, rate: @rating_appointment.rate, user_id: @rating_appointment.user_id } }
    assert_redirected_to rating_appointment_url(@rating_appointment)
  end

  test "should destroy rating_appointment" do
    assert_difference("RatingAppointment.count", -1) do
      delete rating_appointment_url(@rating_appointment)
    end

    assert_redirected_to rating_appointments_url
  end
end
