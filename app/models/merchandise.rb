# frozen_string_literal: true

# Merchandise
class Merchandise < ApplicationRecord
    validates :link, presence: true
    validates :title, presence: true
end