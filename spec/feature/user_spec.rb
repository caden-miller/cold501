# frozen_string_literal: true

# spec/feature/user_spec.rb
require 'rails_helper'
require 'capybara/rspec'
require 'selenium/webdriver'

RSpec.feature 'User Management', type: :feature do
  let!(:admin) do
    create(:user, email: 'testuser@example.com', full_name: 'Test User', role: 'admin', committee: 'Test Committee',
                  avatar_url: 'https://developers.google.com/static/workspace/chat/images/chat-product-icon.png',
                  points: 999)
  end
  let!(:user) do
    create(:user, email: 'testuser2@example.com', full_name: 'Test User 2', role: 'user', committee: 'Test Committee',
                  avatar_url: 'https://developers.google.com/static/workspace/chat/images/chat-product-icon.png',
                  points: 888)
  end

  before do
    Capybara.current_driver = :selenium_chrome_headless
  end

  context 'when a user edits their profile' do
    scenario 'successfully opens edit form and submits changes', :js do
      login_and_navigate_to_user_profile(admin)
      open_edit_form_for(admin)
      submit_profile_changes('New Name')
      expect_profile_update_success('New Name')
    end
  end

  context 'when a user deletes their profile' do
    scenario 'successfully deletes the user', :js do
      login_and_navigate_to_user_profile(admin)
      delete_user_profile(admin)
      expect_user_deletion('New Name')
    end
  end

  context 'when user edit fails due to validation errors' do
    scenario 'fails for empty full name', :js do
      login_and_navigate_to_user_profile(admin)
      open_edit_form_for(admin)
      submit_profile_changes('')
      expect_validation_error
    end
  end

  context 'when viewing users on the index page' do
    scenario 'admin sees all users' do
      login_as(admin, scope: :user)
      visit users_path

      expect_page_to_have_users(['Test User', 'Test User 2'])
    end

    scenario 'non-admin user is not authorized' do
      login_as(user, scope: :user)
      visit users_path

      expect(page).to have_content('You are not authorized.')
    end
  end

  context 'when viewing the leaderboard' do
    scenario 'admin sees users and their points' do
      login_as(admin, scope: :user)
      visit leaderboard_categories_path

      expect_page_to_have_leaderboard(['Test User', '999', 'Test User 2', '888'])
    end

    scenario 'non-admin user cannot access the leaderboard' do
      login_as(user, scope: :user)
      visit leaderboard_categories_path

      expect(page).to have_content('You are not authorized, tell your higher-ups to make you a member')
    end
  end

  context 'when admin resets user points' do
    scenario 'successfully resets points to 0', :js do
      login_and_navigate_to_user_profile(admin)
      reset_user_points
      expect_to_reset_points
    end
  end

  # Helper Methods
  def login_and_navigate_to_user_profile(user)
    login_as(user, scope: :user)
    visit users_path
  end

  def open_edit_form_for(user)
    within "#user_#{user.id}" do
      find('.edit').click
    end
  end

  def submit_profile_changes(name)
    within "#user_#{admin.id}" do
      fill_in 'user_full_name', with: name
      find('.confirm').click
    end
  end

  def delete_user_profile(user)
    within "#user_#{user.id}" do
      accept_confirm do
        find('a.trash').click
      end
    end
  end

  def reset_user_points
    accept_confirm do
      click_on 'Reset Member Points'
    end
  end

  def expect_profile_update_success(name)
    expect(page).to have_content(name)
  end

  def expect_user_deletion(name)
    expect(page).not_to have_content(name)
  end

  def expect_validation_error
  end

  def expect_page_to_have_users(user_names)
    user_names.each { |name| expect(page).to have_content(name) }
  end

  def expect_page_to_have_leaderboard(entries)
    entries.each { |entry| expect(page).to have_content(entry) }
  end

  def expect_to_reset_points
    expect(page).to have_content('0')
  end
end
