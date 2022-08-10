class Address < ApplicationRecord
  acts_as_paranoid

  belongs_to :user
  has_many :orders
end
