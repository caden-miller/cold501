# frozen_string_literal: true

require 'rails_helper'
require 'capybara/rspec'

RSpec.feature 'Merchandises Management', type: :feature do
  let(:admin_user) { create(:user, email: 'admin@example.com', role: 'admin') }

  before do
    login_as(admin_user, scope: :user) # Logs in as an admin user before each scenario
  end

  scenario 'User views the merchandise index page' do
    visit merchandises_path
    expect(page).to have_content('Merchandise')
  end

  context 'when creating a new merchandise' do
    let(:title) { 'Sample Merchandise' }
    let(:description) { 'A new item' }
    let(:link) { 'https://tamu.estore.flywire.com/sample-link' }

    before do
      visit new_merchandise_path
      fill_in 'Title', with: title
      fill_in 'Description', with: description
      fill_in 'Link', with: link
      click_button 'Submit'
    end

    scenario 'successfully creates merchandise with a valid Flywire link' do
      expect(page).to have_content('Merchandise was successfully created.')
    end

    scenario 'displays the created merchandise title' do
      expect(page).to have_content(title)
    end

    scenario 'displays the created merchandise description' do
      expect(page).to have_content(description)
    end

    context 'with an invalid Flywire link' do
      let(:link) { 'https://invalid.link.com' }

      before do
        visit new_merchandise_path
        fill_in 'Title', with: 'Sample Merchandise'
        fill_in 'Description', with: 'A new item'
        fill_in 'Link', with: link
        click_button 'Submit'
      end

      scenario 'fails to create merchandise with an invalid Flywire link' do
        expect(page).to have_content('Please enter a valid Flywire link.')
      end
    end
  end

  context 'when updating an existing merchandise' do
    let(:merchandise) { create(:merchandise, title: 'Old Title', description: 'Old Description', link: 'https://tamu.estore.flywire.com/sample-link') }
    let(:updated_title) { 'Updated Title' }
    let(:updated_description) { 'Updated Description' }
    let(:updated_link) { 'https://tamu.estore.flywire.com/updated-link' }

    before do
      merchandise # Ensures the merchandise is created
      visit edit_merchandise_path(merchandise)
      fill_in 'Title', with: updated_title
      fill_in 'Description', with: updated_description
      fill_in 'Link', with: updated_link
      click_button 'Submit'
    end

    scenario 'successfully updates merchandise with valid data' do
      expect(page).to have_content('Merchandise was successfully updated.')
    end

    scenario 'displays the updated merchandise title' do
      expect(page).to have_content(updated_title)
    end

    scenario 'displays the updated merchandise description' do
      expect(page).to have_content(updated_description)
    end

    scenario 'fails to update merchandise with an invalid Flywire link' do
      visit edit_merchandise_path(merchandise)
      fill_in 'Link', with: 'https://invalid.link.com'
      click_button 'Submit'
      expect(page).to have_content('Please enter a valid Flywire link.')
    end
  end

  context 'when deleting an existing merchandise' do
    let(:merchandise) { create(:merchandise, title: 'To Be Deleted', description: 'A delete test', link: 'https://tamu.estore.flywire.com/delete-test') }

    before do
      merchandise # Ensures the merchandise is created
      visit merchandises_path
    end

    scenario 'successfully deletes a merchandise and shows success message' do
      within(find('.merch-item', text: merchandise.title)) do
        click_button 'Delete'
      end
      expect(page).to have_content('Merchandise was successfully destroyed.')
    end

    scenario 'removes the deleted merchandise from the list' do
      within(find('.merch-item', text: merchandise.title)) do
        click_button 'Delete'
      end
      expect(page).not_to have_content('To Be Deleted')
    end
  end
end
