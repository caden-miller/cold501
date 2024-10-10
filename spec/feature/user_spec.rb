# spec/feature/user_spec.rb
require 'rails_helper'

require 'capybara/rspec'
require 'selenium/webdriver'


RSpec.feature "Edit User and View User in Index then Delete the User", type: :feature do
  let!(:user) { create(:user, email: 'testuser@example.com', full_name: 'Test User', role: 'admin', committee: 'Test Committee', avatar_url: 'https://developers.google.com/static/workspace/chat/images/chat-product-icon.png') }


  before do
    Capybara.current_driver = :selenium_chrome_headless
  end


  scenario "succeeds", js: true do
    # Simulate user login (assuming you are using Devise)
    login_as(user, scope: :user)

    # Visit the edit page
    visit edit_user_path(user)

    # Ensure the form contains the current user's data
    expect(page).to have_field('Full name', with: 'Test User')
    expect(page).to have_field('Committee', with: 'Test Committee')

    # Fill in new details and submit the form
    fill_in 'Full name', with: 'New Name'
    fill_in 'Committee', with: 'New Committee'
    select 'admin', from: 'Role'
    click_button 'Update User'

    # Ensure the page redirects and shows a success message
    expect(page).to have_content('User was successfully updated.')

    # Ensure the user's details were updated correctly
    user.reload
    expect(user.full_name).to eq('New Name')
    expect(user.committee).to eq('New Committee')
    expect(user.role).to eq('admin')
    visit users_path

    expect(page).to have_content('New Name')
    
    accept_confirm 'Are you sure?' do
      click_link 'Delete', href: user_path(user)
    end
  

    # Confirm that the user is deleted and no longer visible on the page
    expect(page).not_to have_content(user.full_name)
  end

  scenario "fails" do
    login_as(user, scope: :user)
    visit edit_user_path(user)

    # Fill in invalid data
    fill_in 'Full name', with: ''
    click_button 'Update User'

    # Ensure the form re-renders with error messages
    expect(page).to have_content("Full name can't be blank")
    expect(page).to have_selector('form')
  end

end

RSpec.feature "View users on index", type: :feature do
  let!(:admin) { create(:user, email: 'testuser@example.com', full_name: 'Test User', role: 'admin', committee: 'Test Committee', avatar_url: 'https://developers.google.com/static/workspace/chat/images/chat-product-icon.png') }
  let!(:user) { create(:user, email: 'testuser2@example.com', full_name: 'Test User 2', role: 'user', committee: 'Test Committee', avatar_url: 'https://developers.google.com/static/workspace/chat/images/chat-product-icon.png') }


  scenario "succeeds" do
    login_as(admin, scope: :user)
    visit users_path

    expect(page).to have_content('Test User')
    expect(page).to have_content('Test User 2')
  end

  scenario "fails" do
    login_as(user, scope: :user)
    visit users_path

    expect(page).to have_content('You are not authorized.')
  end
end


RSpec.feature "View Users on Leaderboard", type: :feature do
  let!(:admin) { create(:user, email: 'testuser@example.com', full_name: 'Test User', role: 'admin', committee: 'Test Committee', avatar_url: 'https://developers.google.com/static/workspace/chat/images/chat-product-icon.png') }
  let!(:user) { create(:user, email: 'testuser2@example.com', full_name: 'Test User 2', role: 'user', committee: 'Test Committee', avatar_url: 'https://developers.google.com/static/workspace/chat/images/chat-product-icon.png') }


  scenario "succeeds" do
    login_as(admin, scope: :user)
    visit leaderboard_users_path

    expect(page).to have_content('Hello! I am currently not built-out yet :(')
  end

  scenario "fails" do
    login_as(user, scope: :user)
    visit leaderboard_users_path

    expect(page).to have_content('You are not authorized, tell your higher-ups to make you a member')
  end
end
