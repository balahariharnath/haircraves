class Order < ApplicationRecord
  acts_as_paranoid

  belongs_to :user
  belongs_to :address
  belongs_to :item
  belongs_to :seller, class_name: 'User'
  # has_many :rating_orders
  # has_many :rate_users, class_name: 'User', through: :rating_orders, source: :order

  enum status: ['Ordered', 'Packed', 'Shipped', 'On the way', 'Delivered', 'Cancelled', 'Returned']
end
