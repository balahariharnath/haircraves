class RateServiceProvider < ApplicationRecord
  after_save do
    stylist.update(average_rating: stylist.ratings.average('rate'))
  end

  belongs_to :user
  belongs_to :stylist, class_name: "User", counter_cache: :rating_count

  validates :rate, presence: true

end
