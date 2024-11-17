# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Photo, type: :model do
  subject(:photo) do
    described_class.new(
      title: 'Sample Photo',
      description: 'This is a sample photo description',
      image:,
      user:
    )
  end

  let(:user) { create(:user) }
  let(:image) { File.open(Rails.root.join('spec/fixtures/sample.jpg')) }

  describe 'validations' do
    context 'with valid attributes' do
      it 'is valid' do
        expect(photo).to be_valid
      end
    end

    context 'without a title' do
      before do
        photo.title = nil
      end

      it 'is not valid' do
        expect(photo).not_to be_valid
      end

      it 'adds an error for title' do
        photo.validate
        expect(photo.errors[:title]).to include("can't be blank")
      end
    end

    context 'without a description' do
      before do
        photo.description = nil
      end

      it 'is not valid' do
        expect(photo).not_to be_valid
      end

      it 'adds an error for description' do
        photo.validate
        expect(photo.errors[:description]).to include("can't be blank")
      end
    end

    context 'without an image' do
      before do
        photo.image = nil
      end

      it 'is not valid' do
        expect(photo).not_to be_valid
      end

      it 'adds an error for image' do
        photo.validate
        expect(photo.errors[:image]).to include("can't be blank")
      end
    end

    context 'without a user' do
      before do
        photo.user = nil
      end

      it 'is not valid' do
        expect(photo).not_to be_valid
      end

      it 'adds an error for user' do
        photo.validate
        expect(photo.errors[:user]).to include('must exist')
      end
    end
  end
end
