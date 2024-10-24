# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LeaderboardCategory, type: :model do
  subject(:category) do
    described_class.new(category_name: 'Test Name', min_points: 1, color: 'blue')
  end

  context 'with valid attributes' do
    it 'is valid' do
      expect(category).to be_valid
    end

    it 'has the correct category name' do
      expect(category.category_name).to eq('Test Name')
    end

    it 'has the correct min_points' do
      expect(category.min_points).to eq(1)
    end

    it 'has the correct color' do
      expect(category.color).to eq('blue')
    end
  end

  context 'when category name is missing' do
    it 'is not valid' do
      category.category_name = nil
      expect(category).not_to be_valid
    end
  end
end
