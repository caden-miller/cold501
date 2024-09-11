# spec/feature/users/edit_spec.rb
require 'rails_helper'

RSpec.feature "Edit User", type: :feature do
  let!(:user) { create(:user, email: 'testuser@example.com', full_name: 'Test User', role: 'admin', committee: 'Test Committee') }

  scenario "succeeds" do
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
    click_button 'Update User'

    # Ensure the page redirects and shows a success message
    expect(page).to have_content('User updated successfully.')

    # Ensure the user's details were updated correctly
    user.reload
    expect(user.full_name).to eq('New Name')
    expect(user.committee).to eq('New Committee')
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

