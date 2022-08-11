class Appointment < ApplicationRecord
  belongs_to :user
  # has_many :rating_appointments, dependent: :destroy
  has_many :appointment_services, dependent: :destroy
  has_many :services, through: :appointment_services, source: :service
  belongs_to :stylist, class_name: 'User'

  accepts_nested_attributes_for :services


  enum status: ["Requested", "Accepted", "Rejected", "Cancelled", "Active", "Completed"]
end
