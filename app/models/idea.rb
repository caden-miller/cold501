# frozen_string_literal: true

class Idea < ApplicationRecord
  validates :title, presence: true
  belongs_to :user, foreign_key: 'created_by' , optional: true

end
