class Category < ApplicationRecord
  has_many :items, dependent: :destroy
  belongs_to :user

  validates_presence_of :category_name
end
