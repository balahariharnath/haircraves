class Post < ApplicationRecord
  include Rails.application.routes.url_helpers

  belongs_to :user
  belongs_to :service_category
  has_one_attached :image
  has_and_belongs_to_many :tag_users, class_name: 'User', join_table: 'posts_users'
  has_and_belongs_to_many :items, join_table: 'posts_items'
  has_many :comments
  has_many :comment_users, class_name: 'User', through: :comments, source: :post
  has_and_belongs_to_many :likes, join_table: 'likes', class_name: 'User'

  accepts_nested_attributes_for :tag_users
  accepts_nested_attributes_for :items


  def image_url
    self.image.present? ? rails_blob_path(self.image, disposition: "attachment", only_path: true) : nil
  end

  def as_json(opts ={})
    super.merge(comments_count: comments.size, likes_count: likes.size)
  end
end
