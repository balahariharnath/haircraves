require "application_system_test_case"

class RatingAppointmentsTest < ApplicationSystemTestCase
  setup do
    @rating_appointment = rating_appointments(:one)
  end

  test "visiting the index" do
    visit rating_appointments_url
    assert_selector "h1", text: "Rating appointments"
  end

  test "should create rating appointment" do
    visit rating_appointments_url
    click_on "New rating appointment"

    fill_in "Appointment", with: @rating_appointment.appointment_id
    fill_in "Rate", with: @rating_appointment.rate
    fill_in "User", with: @rating_appointment.user_id
    click_on "Create Rating appointment"

    assert_text "Rating appointment was successfully created"
    click_on "Back"
  end

  test "should update Rating appointment" do
    visit rating_appointment_url(@rating_appointment)
    click_on "Edit this rating appointment", match: :first

    fill_in "Appointment", with: @rating_appointment.appointment_id
    fill_in "Rate", with: @rating_appointment.rate
    fill_in "User", with: @rating_appointment.user_id
    click_on "Update Rating appointment"

    assert_text "Rating appointment was successfully updated"
    click_on "Back"
  end

  test "should destroy Rating appointment" do
    visit rating_appointment_url(@rating_appointment)
    click_on "Destroy this rating appointment", match: :first

    assert_text "Rating appointment was successfully destroyed"
  end
end
