# frozen_string_literal: true

# Idea
class Idea < ApplicationRecord
  validates :title, presence: true

  belongs_to :user, foreign_key: 'created_by', inverse_of: :ideas
end
