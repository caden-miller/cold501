# frozen_string_literal: true

# location: spec/unit/users/unit_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) do
    described_class.new(email: 'testemail@test.com', full_name: 'Test Name')
  end

  context 'with valid attributes' do
    it 'is valid' do
      user.full_name = 'Test Name'
      user.role = 'admin'
      expect(user).to be_valid
    end

    it 'has the correct full name' do
      user.full_name = 'Test Name'
      expect(user.full_name).to eq('Test Name')
    end
  end

  it 'is not valid without a name' do
    user.full_name = nil
    expect(user).not_to be_valid
  end
end
