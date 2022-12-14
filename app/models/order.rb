class Order < ApplicationRecord
  acts_as_paranoid

  #=============== Associations =========================================================
  belongs_to :user
  belongs_to :address
  belongs_to :item
  belongs_to :seller, class_name: 'User'
  # has_many :rating_orders
  # has_many :rate_users, class_name: 'User', through: :rating_orders, source: :order

  #=============== Callbacks ============================================================
  before_save :delivery_update

  enum status: ['Ordered', 'Packed', 'Shipped', 'On the way', 'Delivered', 'Cancelled', 'Returned']

  def delivery_update
    if status == 'Delivered'
      self.delivered_date = Time.now
    end
  end
end
