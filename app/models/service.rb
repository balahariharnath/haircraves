class Service < ApplicationRecord
  belongs_to :user
  belongs_to :service_category
  has_many :appointment_services
  has_many :appointments, through: :appointment_services, source: :appointment


end
