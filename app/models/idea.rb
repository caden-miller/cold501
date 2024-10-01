# frozen_string_literal: true

class Idea < ApplicationRecord
  validates :title, presence: true
end
