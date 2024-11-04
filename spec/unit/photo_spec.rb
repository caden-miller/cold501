# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Photo, type: :model do
  let(:user) { create(:user) }
  let(:image) { File.open(Rails.root.join('spec/fixtures/sample.jpg')) } # Make sure to have a test image in this path

  subject do
    described_class.new(
      title: 'Sample Photo',
      description: 'This is a sample photo description',
      image: image,
      user: user
    )
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a title' do
      subject.title = nil
      expect(subject).not_to be_valid
      expect(subject.errors[:title]).to include("can't be blank")
    end

    it 'is not valid without a description' do
      subject.description = nil
      expect(subject).not_to be_valid
      expect(subject.errors[:description]).to include("can't be blank")
    end

    it 'is not valid without an image' do
      subject.image = nil
      expect(subject).not_to be_valid
      expect(subject.errors[:image]).to include("can't be blank")
    end

    it 'is not valid without a user' do
      subject.user = nil
      expect(subject).not_to be_valid
      expect(subject.errors[:user]).to include('must exist')
    end
  end

  
end
