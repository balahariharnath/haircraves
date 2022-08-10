class ServiceCategory < ApplicationRecord
  has_many :services
  has_many :posts
end
