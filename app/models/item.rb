class Item < ApplicationRecord
  include Rails.application.routes.url_helpers

  belongs_to :category
  belongs_to :user
  has_many :orders
  has_many_attached :images, dependent: :destroy
  has_one_attached :video, dependent: :destroy
  has_many :item_favorites, dependent: :destroy
  has_many :users, through: :item_favorites, source: :user
  has_and_belongs_to_many :tag_posts, class_name: 'Post', join_table: 'posts_items'
  has_many :cart_products, dependent: :destroy
  has_many :carts, through: :cart_products, source: :cart
  has_many :item_ratings
  has_many :rating_users, class_name: "User", through: :item_ratings, source: :user


  def image_urls
    self.images.present? ? self.images.map do |image|  rails_blob_path(image, disposition: "attachment", only_path: true) end : nil
  end

  def video_url
    self.video.present? ?  rails_blob_path(self.video, disposition: "attachment", only_path: true) : nil
  end
end
