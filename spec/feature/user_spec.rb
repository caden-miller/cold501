# frozen_string_literal: true

# spec/feature/user_spec.rb
require 'rails_helper'

require 'capybara/rspec'
require 'selenium/webdriver'

RSpec.feature 'Edit User and View User in Index then Delete the User', type: :feature do
  let!(:user) do
    create(:user, email: 'testuser@example.com', full_name: 'Test User', role: 'admin', committee: 'Test Committee',
                  avatar_url: 'https://developers.google.com/static/workspace/chat/images/chat-product-icon.png')
  end

  before do
    Capybara.current_driver = :selenium_chrome_headless
  end

  scenario 'User edits and deletes their profile', js: true do
    # Simulate user login (assuming you are using Devise)
    login_as(user, scope: :user)

    # Visit the users index page
    visit users_path

    # Ensure the page contains the current user's data
    expect(page).to have_content('Test User')
    expect(page).to have_content('Test Committee')

    # Click the edit button within the user's turbo frame
    within "#user_#{user.id}" do
      find('.edit').click
    end

    # Fill in the 'Full name' field with 'New Name'
    within "#user_#{user.id}" do
      fill_in 'user_full_name', with: 'New Name'
      # Click the confirm button to submit the form
      find('.confirm').click
    end

    # Wait for the page to update and check for new name
    expect(page).to have_content('New Name')

    visit users_path

    # Delete the user
    within "#user_#{user.id}" do
      # Handle the confirmation dialog
      accept_confirm do
        find('a.trash').click
      end
    end

    # Verify the user is deleted and no longer visible on the page
    expect(page).not_to have_content('New Name')
  end

  scenario 'User edit fails due to validation errors', js: true do
    login_as(user, scope: :user)
    visit users_path

    # Click the edit button within the user's turbo frame
    within "#user_#{user.id}" do
      find('.edit').click
    end

    # Fill in invalid data
    within "#user_#{user.id}" do
      fill_in 'user_full_name', with: ''
      find('.confirm').click
    end

    # Ensure the form re-renders with error messages
    expect(page).to have_content('Please review the problems below:')
    expect(page).to have_selector('form.user.form')
  end
end

RSpec.feature 'View users on index', type: :feature do
  let!(:admin) do
    create(:user, email: 'testuser@example.com', full_name: 'Test User', role: 'admin', committee: 'Test Committee',
                  avatar_url: 'https://developers.google.com/static/workspace/chat/images/chat-product-icon.png')
  end
  let!(:user) do
    create(:user, email: 'testuser2@example.com', full_name: 'Test User 2', role: 'user', committee: 'Test Committee',
                  avatar_url: 'https://developers.google.com/static/workspace/chat/images/chat-product-icon.png')
  end

  scenario 'succeeds' do
    login_as(admin, scope: :user)
    visit users_path

    expect(page).to have_content('Test User')
    expect(page).to have_content('Test User 2')
  end

  scenario 'fails' do
    login_as(user, scope: :user)
    visit users_path

    expect(page).to have_content('You are not authorized.')
  end
end

RSpec.feature 'View Users on Leaderboard', type: :feature do
  let!(:admin) do
    create(:user, email: 'testuser@example.com', full_name: 'Test User', role: 'admin', committee: 'Test Committee',
                  avatar_url: 'https://developers.google.com/static/workspace/chat/images/chat-product-icon.png')
  end
  let!(:user) do
    create(:user, email: 'testuser2@example.com', full_name: 'Test User 2', role: 'user', committee: 'Test Committee',
                  avatar_url: 'https://developers.google.com/static/workspace/chat/images/chat-product-icon.png')
  end

  scenario 'succeeds' do
    login_as(admin, scope: :user)
    visit leaderboard_users_path

    expect(page).to have_content('Hello! I am currently not built-out yet :(')
  end

  scenario 'fails' do
    login_as(user, scope: :user)
    visit leaderboard_users_path

    expect(page).to have_content('You are not authorized, tell your higher-ups to make you a member')
  end
end

RSpec.feature 'Reset User Points', type: :feature do
  let!(:admin) do
    create(:user, email: 'testuser@example.com', full_name: 'Test User', role: 'admin', committee: 'Test Committee', points: 10,
                  avatar_url: 'https://developers.google.com/static/workspace/chat/images/chat-product-icon.png')
  end

  before do
    Capybara.current_driver = :selenium_chrome_headless
  end

  scenario 'succeeds' do
    login_as(admin, scope: :user)
    visit users_path

    expect(page).to have_content('Test User')
    expect(page).to have_content('10')

    accept_confirm do
      click_on 'Reset Member Points'
    end

    expect(page).to have_content('0')
  end
end
