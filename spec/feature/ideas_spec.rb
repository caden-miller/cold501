# frozen_string_literal: true

require 'rails_helper'
require 'capybara/rspec'

RSpec.feature 'Ideas Management', type: :feature do
  let!(:user) { create(:user) }

  before do
    login_as(user, scope: :user)
  end

  scenario 'User views the ideas index page' do
    visit ideas_path
    expect(page).to have_content('IDEAS')
  end

  context 'when creating a new idea' do
    def fill_in_new_idea_form(title:, description:)
      visit new_idea_path
      fill_in 'Write your title here', with: title
      fill_in 'Write description here', with: description
      click_button 'Submit'
    end

    scenario 'successfully creates an idea with valid data' do
      fill_in_new_idea_form(title: 'New Idea', description: 'An innovative concept')
      expect(page).to have_content('Idea was successfully created.')
    end

    scenario 'displays the created idea title' do
      fill_in_new_idea_form(title: 'New Idea', description: 'An innovative concept')
      expect(page).to have_content('New Idea')
    end

    scenario 'displays the created idea description' do
      fill_in_new_idea_form(title: 'New Idea', description: 'An innovative concept')
      expect(page).to have_content('An innovative concept')
    end

    scenario 'fails to create an idea without a title' do
      fill_in_new_idea_form(title: '', description: 'An innovative concept')
      expect(page).to have_content("Title can't be blank")
    end

    scenario 'fails to create an idea without a description' do
      fill_in_new_idea_form(title: 'New Idea', description: '')
      expect(page).to have_content("Description can't be blank")
    end
  end

  context 'when updating an existing idea' do
    let!(:idea) { create(:idea, title: 'Old Title', description: 'Old Description', user:) }

    def fill_in_edit_idea_form(title:, description:)
      visit edit_idea_path(idea)
      fill_in 'Write your title here', with: title
      fill_in 'Write description here', with: description
      click_button 'Submit'
    end

    scenario 'successfully updates an idea with valid data' do
      fill_in_edit_idea_form(title: 'Updated Title', description: 'Updated Description')
      expect(page).to have_content('Idea was successfully updated.')
    end

    scenario 'displays the updated idea title' do
      fill_in_edit_idea_form(title: 'Updated Title', description: 'Updated Description')
      expect(page).to have_content('Updated Title')
    end

    scenario 'displays the updated idea description' do
      fill_in_edit_idea_form(title: 'Updated Title', description: 'Updated Description')
      expect(page).to have_content('Updated Description')
    end

    scenario 'fails to update an idea without a title' do
      fill_in_edit_idea_form(title: '', description: 'Updated Description')
      expect(page).to have_content("Title can't be blank")
    end

    scenario 'fails to update an idea without a description' do
      fill_in_edit_idea_form(title: 'Updated Title', description: '')
      expect(page).to have_content("Description can't be blank")
    end
  end

  context 'when deleting an existing idea' do
    let!(:idea) { create(:idea, title: 'Delete Me', description: 'To be deleted', user:) }

    scenario 'successfully deletes an idea and shows success message' do
      visit ideas_path
      within("#idea_#{idea.id}") do
        click_button 'Delete'
      end
      expect(page).to have_content('Idea was successfully deleted.')
    end

    scenario 'removes the deleted idea from the list' do
      visit ideas_path
      within("#idea_#{idea.id}") do
        click_button 'Delete'
      end
      expect(page).not_to have_content('Delete Me')
    end
  end
end
