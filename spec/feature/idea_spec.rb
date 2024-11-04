# spec/features/ideas_spec.rb
require 'rails_helper'

RSpec.feature 'Ideas management', type: :feature do
  let!(:user) do
    create(:user, email: 'testuser@example.com', full_name: 'Test User', role: 'admin', committee: 'Test Committee',
                  avatar_url: 'https://developers.google.com/static/workspace/chat/images/chat-product-icon.png')
  end

  let!(:idea) { create(:idea, title: 'Original Idea', description: 'An idea description', user: user) }

  before do
    login_as(user, scope: :user) # Ensure the user is signed in for all tests
  end

  scenario 'User views the list of ideas' do
    visit ideas_path
    expect(page).to have_content 'Original Idea'
    expect(page).to have_content 'An idea description'
  end

  scenario 'User creates a new idea' do
    visit new_idea_path

    fill_in 'Title', with: 'New Idea'
    fill_in 'description-field', with: 'A new idea description' # Use the specific id for the description field
    click_button 'Create Idea'

    expect(page).to have_content 'Idea was successfully created.'
    expect(page).to have_content 'New Idea'
    expect(page).to have_content 'A new idea description'
  end

  scenario 'User fails to create a new idea with missing title' do
    visit new_idea_path

    fill_in 'Title', with: '' # Leave title blank to trigger validation error
    fill_in 'description-field', with: 'A new idea without a title'
    click_button 'Create Idea'

    expect(page).to have_content "Title can't be blank" # Check for the error message
  end

  scenario 'User views an idea' do
    visit idea_path(idea)

    expect(page).to have_content 'Original Idea'
    expect(page).to have_content 'An idea description'
  end

  scenario 'User edits an idea' do
    visit edit_idea_path(idea)

    fill_in 'Title', with: 'Updated Idea Title'
    fill_in 'description-field', with: 'Updated description' # Use the specific id for the description field
    click_button 'Update Idea'

    expect(page).to have_content 'Idea was successfully updated.'
    expect(page).to have_content 'Updated Idea Title'
    expect(page).to have_content 'Updated description'
  end

  scenario 'User fails to update an idea with invalid data' do
    visit edit_idea_path(idea)

    fill_in 'Title', with: '' # Leave title blank to trigger validation error
    click_button 'Update Idea'

    expect(page).to have_content "Title can't be blank" # Check for the error message
  end

  scenario 'User deletes an idea' do
    # First, navigate to the show page for the specific idea
    visit idea_path(idea)
  
    # Confirm that we're on the show page for the idea
    expect(page).to have_content 'Original Idea'
    expect(page).to have_content 'An idea description'
  
    # Now, use `click_button` to delete the idea using the "Destroy this idea" button
    click_button 'Destroy this idea'
  
    # Check for a success message and that the idea no longer appears
    expect(page).to have_content 'Idea was successfully destroyed.'
    expect(page).not_to have_content 'Original Idea'
  end
end  
 
