class ItemRating < ApplicationRecord
  after_save do
    item.update(average_rating: item.item_ratings.average('rate'))
  end
  belongs_to :user
  belongs_to :item, counter_cache: :rating_count

  validates :rate, presence: true
end
