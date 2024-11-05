# frozen_string_literal: true

# Link
class Link < ApplicationRecord
  validates :title, presence: true
  validates :link, presence: true
end
