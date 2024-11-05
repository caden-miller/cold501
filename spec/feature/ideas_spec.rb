# frozen_string_literal: true

require 'rails_helper'
require 'capybara/rspec'

RSpec.feature 'Ideas', type: :feature do
  let!(:user) { create(:user) } # Create a test user for authentication
  
  before do
    login_as(user, scope: :user)
  end

  scenario 'User views the ideas index page' do
    visit ideas_path
    expect(page).to have_content('Ideas')
  end

# spec/feature/ideas_spec.rb

scenario 'User creates a new idea with valid data' do
  visit new_idea_path

  fill_in placeholder: 'Write your title here', with: 'New Idea'
  fill_in placeholder: 'Write description here', with: 'An innovative concept'
  click_button 'Submit'

  expect(page).to have_content('Idea was successfully created.')
  expect(page).to have_content('New Idea')
  expect(page).to have_content('An innovative concept')
end

scenario 'User fails to create a new idea with invalid data' do
  visit new_idea_path

  fill_in placeholder: 'Write your title here', with: ''
  fill_in placeholder: 'Write description here', with: ''
  click_button 'Submit'

  expect(page).to have_content("Title can't be blank")
  expect(page).to have_content("Description can't be blank")
end

scenario 'User updates an existing idea with valid data' do
  idea = create(:idea, title: 'Old Title', description: 'Old Description', user: user)
  visit edit_idea_path(idea)

  fill_in placeholder: 'Write your title here', with: 'Updated Title'
  fill_in placeholder: 'Write description here', with: 'Updated Description'
  click_button 'Submit'

  expect(page).to have_content('Idea was successfully updated.')
  expect(page).to have_content('Updated Title')
  expect(page).to have_content('Updated Description')
end

scenario 'User fails to update an idea with invalid data' do
  idea = create(:idea, title: 'Old Title', description: 'Old Description', user: user)
  visit edit_idea_path(idea)

  fill_in placeholder: 'Write your title here', with: ''
  fill_in placeholder: 'Write description here', with: ''
  click_button 'Submit'

  expect(page).to have_content("Title can't be blank")
  expect(page).to have_content("Description can't be blank")
end


scenario 'User updates an existing idea with valid data' do
  idea = create(:idea, title: 'Old Title', description: 'Old Description', user: user)
  visit edit_idea_path(idea)

  fill_in placeholder: 'Write your title here', with: 'Updated Title'
  fill_in placeholder: 'Write description here', with: 'Updated Description'
  click_button 'Submit'

  expect(page).to have_content('Idea was successfully updated.')
  expect(page).to have_content('Updated Title')
  expect(page).to have_content('Updated Description')
end

scenario 'User fails to update an idea with invalid data' do
  idea = create(:idea, title: 'Old Title', description: 'Old Description', user: user)
  visit edit_idea_path(idea)

  fill_in placeholder: 'Write your title here', with: ''
  fill_in placeholder: 'Write description here', with: ''
  click_button 'Submit'

  expect(page).to have_content("Title can't be blank")
  expect(page).to have_content("Description can't be blank")
end

  scenario 'User deletes an existing idea' do
    idea = create(:idea, title: 'Delete Me', description: 'To be deleted', user: user)
    visit ideas_path

    within("#idea_#{idea.id}") do
      click_button 'Delete'
    end

    expect(page).to have_content('Idea was successfully deleted.')
    expect(page).not_to have_content('Delete Me')
  end
end
