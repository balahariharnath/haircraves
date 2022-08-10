class ServiceFavorite < ApplicationRecord
  belongs_to :user
  belongs_to :stylist, class_name: 'User'
end
