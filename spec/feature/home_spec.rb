# frozen_string_literal: true

# spec/feature/user_spec.rb
require 'rails_helper'

RSpec.feature 'View Nav', type: :feature do
  let!(:member) do
    create(:user, email: 'testuser@example.com', full_name: 'Test User', role: 'member', committee: 'Test Committee',
                  avatar_url: 'https://developers.google.com/static/workspace/chat/images/chat-product-icon.png')
  end
  let!(:officer) do
    create(:user, email: 'testuser2@example.com', full_name: 'Test User 2', role: 'officer', committee: 'Test Committee',
                  avatar_url: 'https://developers.google.com/static/workspace/chat/images/chat-product-icon.png')
  end

  scenario 'as Member' do
    login_as(member, scope: :user)
    visit root_path

    expect(page).to have_content('members')
  end

  scenario 'as Officer' do
    login_as(officer, scope: :user)
    visit root_path

    # expect navbar to not have members
    within('header') do
      expect(page).to_not have_content('members')
    end
  end
end

RSpec.feature 'Login vs Logout', type: :feature do
  let!(:member) do
    create(:user, email: 'testuser@example.com', full_name: 'Test User', role: 'member', committee: 'Test Committee',
                  avatar_url: 'https://developers.google.com/static/workspace/chat/images/chat-product-icon.png')
  end

  scenario 'from non-user to member' do
    visit root_path

    expect(page).to have_content('Login')

    login_as(member, scope: :user)

    visit root_path

    expect(page).to have_content('Logout')
  end
end
