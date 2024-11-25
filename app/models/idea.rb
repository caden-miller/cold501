# frozen_string_literal: true

# Model for storing ideas created by users.
class Idea < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true

  belongs_to :user,
             foreign_key: 'created_by',
             optional: true,
             inverse_of: :ideas
end
