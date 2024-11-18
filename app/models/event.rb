# frozen_string_literal: true

# Event
class Event < ApplicationRecord
  has_many :attendances, dependent: :destroy
  has_many :users, through: :attendances
  validates :name, presence: true
  validates :start_time, :end_time, presence: true
  scope :active, -> { where(archived: false) }
  scope :archived, -> { where(archived: true) }
  before_save :align_end_time_with_start_time
  validate :end_time_after_start_time

  private

  def align_end_time_with_start_time
    return unless start_time.present? && end_time.present?

    self.end_time = end_time.change(
      year: start_time.year,
      month: start_time.month,
      day: start_time.day
    )
  end

  def end_time_after_start_time
    if end_time < start_time
      errors.add(:end_time, "must be after the start time")
    end
  end
end
