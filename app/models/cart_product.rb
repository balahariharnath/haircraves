class CartProduct < ApplicationRecord
  belongs_to :cart
  belongs_to :item

  after_save :update_sub_total
  before_destroy :update_total

  def update_sub_total
    cart.sub_total = cart.sub_total.nil? ? qty * item.price : cart.sub_total + (qty * item.price)
    cart.save
  end

  def update_total
    cart.sub_total = cart.sub_total - (qty * item.price)
    cart.save
  end
end
