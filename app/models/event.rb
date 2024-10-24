# frozen_string_literal: true

# Event
class Event < ApplicationRecord
  has_many :attendances, dependent: :destroy
  validates :name, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  scope :active, -> { where(archived: false) }
  scope :archived, -> { where(archived: true) }
end
