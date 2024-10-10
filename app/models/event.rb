# frozen_string_literal: true

class Event < ApplicationRecord
  has_many :attendances, dependent: :destroy
  validates :name, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
end
