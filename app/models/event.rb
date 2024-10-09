# frozen_string_literal: true

class Event < ApplicationRecord
  validates :name, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
end
