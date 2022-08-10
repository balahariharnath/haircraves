class Availability < ApplicationRecord
  belongs_to :user

  #======= Validations ====================
  validates_presence_of :start_time, :end_time, if: -> {self.active?}
end
