class Portfolio < ApplicationRecord
  include Rails.application.routes.url_helpers

  belongs_to :user
  has_one_attached :image
  has_one_attached :video

  validates_presence_of :title, :content

  def image_url
    self.image.present? ? rails_blob_path(self.image, disposition: "attachment", only_path: true) : nil
  end

  def video_url
    self.video.present? ? rails_blob_path(self.video, disposition: "attachment", only_path: true) : nil
  end
end
