class User < ApplicationRecord
  acts_as_paranoid
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  include Rails.application.routes.url_helpers

  #============== Associations ===========================================
  has_and_belongs_to_many :tag_posts, class_name: 'Post'
  has_and_belongs_to_many :likes, join_table: 'likes', class_name: 'Post'

  has_many :categories
  has_many :items
  has_many :availabilities
  has_many :portfolios
  belongs_to :role
  has_one_attached :image
  has_one_attached :cover_image
  has_many :orders
  has_many :posts
  has_many :comments
  has_many :comment_posts, class_name: 'Post', through: :comments, source: :post
  has_many :addresses
  has_many :categories
  has_one :cart
  has_many :cards
  has_many :services
  has_one :bank
  has_many :appointments
  has_many :sender_conversations, class_name: "Conversation", :foreign_key => "sender_id"
  has_many :receiver_conversations, class_name: "Conversation", :foreign_key => "receiver_id"
  has_many :messages, :foreign_key => 'sender_id'
  has_many :device_infos
  # has_many :rating_appointments
  has_many :item_favorites
  has_many :fav_items, class_name: 'Item', through: :item_favorites, source: :item
  has_many :service_favorites
  has_many :fav_users, class_name: 'User', through: :service_favorites, source: :user
  # has_many :service_users, class_name: 'ServiceFavorite', foreign_key: 'stylist_id'
  has_many :fav_services, class_name: 'User', through: :service_favorites, source: :stylist

  # has_many :rating_orders
  # has_many :rate_orders, class_name: 'Order', through: :rating_orders, source: :order
  has_many :rate_service_providers
  has_many :rate_users, class_name: 'User', through: :rate_service_providers, source: :stylist
  has_many :ratings, foreign_key: 'stylist_id', class_name: "RateServiceProvider"
  has_many :service_appointments, class_name: 'Appointment', foreign_key: "stylist_id"
  has_many :item_ratings
  has_many :rated_items, class_name: 'Item', through: :item_ratings, source: :item
  has_many :seller_orders, class_name: 'Order', foreign_key: 'seller_id'

  #=========================== Validations =======================================================
  validates_presence_of :location, :business_name, :address, if: -> {self.role.role_name == 'stylist' || self.role.role_name == 'business_owner'}
  validates_presence_of :first_name, :last_name, if: -> {self.role.role_name == 'stylist' || self.role.role_name == 'customer'}, on: :update
  validates_presence_of :year_of_exp, if: -> {self.role.role_name == 'stylist'}

  #========================= Callbacks ===========================================================
  after_save :create_availabilities


  def create_availabilities
    return if self.availabilities.present? || self.role.role_name == 'customer'

    days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
    days.each do |day|
      self.availabilities.create(day: day)
    end
  end

  def profile_image_url
    self.image.present? ? rails_blob_path(self.image, disposition: "attachment", only_path: true) : nil
  end

  def cover_image_url
    self.cover_image.present? ? rails_blob_path(self.cover_image, disposition: "attachment", only_path: true) : nil
  end

  # def as_json(opts = {})
  #   user = self
  #   super.merge(profile_image_path: user.image.present? ? url_for(user.image) : nil, cover_image_path:  user.cover_image.present? ? url_for(user.cover_image) : nil )
  # end


  class << self
    def current_user=(user)
      Thread.current[:current_user] = user
    end

    def current_user
      Thread.current[:current_user]
    end
  end

  def send_notification_to_user(title, description)
    payload = {payload: { title: title , description: description } }
    android_condition = "device_type = 'android' and user_id = #{id.to_i}"
    ios_condition = "device_type = 'ios' and user_id = #{id.to_i}"
    send_notification(payload, android_condition, 'android')
    send_notification(payload, ios_condition, 'ios')
  end

  def send_notification(payload, condition, device_type)
    tokens = DeviceInfo.where(condition).pluck(:device_token).compact
    DeviceInfo.send_notification(tokens, payload, device_type)
  end

end
