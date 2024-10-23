# frozen_string_literal: true

# spec/feature/home_spec.rb
require 'rails_helper'

RSpec.feature 'Home Page Features', type: :feature do
  let!(:admin) do
    create(:user, email: 'testuser@example.com', full_name: 'Test User', role: 'admin',
                  committee: 'Test Committee',
                  avatar_url: 'https://developers.google.com/static/workspace/chat/images/chat-product-icon.png')
  end

  let!(:user) do
    create(:user, email: 'testuser2@example.com', full_name: 'Test User 2', role: 'user',
                  committee: 'Test Committee',
                  avatar_url: 'https://developers.google.com/static/workspace/chat/images/chat-product-icon.png')
  end

  context 'when viewing the navigation as different roles' do
    scenario 'as Admin' do
      login_as(admin, scope: :user)
      visit root_path

      expect(page).to have_content('members')
    end

    scenario 'as User' do
      login_as(user, scope: :user)
      visit root_path

      # Expect navbar to not have 'members'
      within('header') do
        expect(page).not_to have_content('members')
      end
    end
  end

  context 'when logging in and out' do
    scenario 'from non-user to admin' do
      visit root_path

      # Separate expectations
      expect_login_content_before(admin)
      expect_logout_content_after
    end
  end

  # Helper methods
  def expect_login_content_before(user)
    expect(page).to have_content('Login')

    login_as(user, scope: :user)
    visit root_path
  end

  def expect_logout_content_after
    expect(page).to have_content('Logout')
  end
end
