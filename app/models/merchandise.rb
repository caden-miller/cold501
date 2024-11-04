# frozen_string_literal: true

class Merchandise < ApplicationRecord
    validates :link, presence: true
    validates :title, presence: true
end