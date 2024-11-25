# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Idea, type: :model do
  let(:user) { create(:user) }
  let(:idea) { build(:idea, user:) } # Use Factory Bot to build an idea with an associated user

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(idea).to be_valid
    end

    it 'is not valid without a title' do
      idea.title = nil
      expect(idea).not_to be_valid
    end
  end

  describe 'associations' do
    it 'belongs to a user' do
      association = described_class.reflect_on_association(:user)
      expect(association.foreign_key).to eq('created_by')
    end
  end
end
