class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_products, dependent: :destroy
  has_many :items, through: :cart_products, source: :item

  accepts_nested_attributes_for :cart_products

end
