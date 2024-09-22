class Photo < ApplicationRecord
  include ImageUploader::Attachment(:image) # Include Shrine uploader

  belongs_to :user

  validates :title, presence: true
  validates :description, presence: true
  validates :image, presence: true
end

