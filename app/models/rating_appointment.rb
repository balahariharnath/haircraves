class RatingAppointment < ApplicationRecord
  belongs_to :user
  belongs_to :appointment
end
