# frozen_string_literal: true

# location: spec/unit/users/unit_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    described_class.new(email: 'testemail@test.com', full_name: 'Test Name')
  end

  it 'is valid with valid attributes' do
    subject.full_name = 'Test Name'
    subject.role = 'admin'
    expect(subject).to be_valid
    expect(subject.full_name).to eq('Test Name')
  end

  it 'is not valid without a name' do
    subject.full_name = nil
    subject.role =
      expect(subject).not_to be_valid
  end
end
