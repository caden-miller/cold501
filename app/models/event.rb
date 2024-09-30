# frozen_string_literal: true

class Event < ApplicationRecord
  validates :name, presence: true
  validates :date, presence: true
end
