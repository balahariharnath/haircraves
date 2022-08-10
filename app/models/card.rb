class Card < ApplicationRecord
  belongs_to :user

  validates_presence_of :card_number, :card_holder_name, :exp_date
end
