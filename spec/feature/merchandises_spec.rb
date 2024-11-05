
# frozen_string_literal: true

require 'rails_helper'
require 'capybara/rspec'

RSpec.feature 'Merchandises', type: :feature do
  let(:officer_user) { create(:user, email: "officer#{Time.now.to_i}@example.com", role: 'officer') }

  before do
    login_as(officer_user, scope: :user) # Logs in as an officer user before each scenario
  end

  scenario 'User views the merchandise index page' do
    visit merchandises_path
    expect(page).to have_content('Merchandise')
  end

# spec/feature/merchandises_spec.rb

scenario 'User creates new merchandise with valid Flywire link' do
    visit new_merchandise_path
  
    fill_in 'Title', with: 'Sample Merchandise'
    fill_in 'Description', with: 'A new item'
    fill_in 'Link', with: 'https://tamu.estore.flywire.com/sample-link'
    click_button 'Submit' # Update to match button text in form
  
    expect(page).to have_content('Merchandise was successfully created.')
    expect(page).to have_content('Sample Merchandise')
    expect(page).to have_content('A new item')
  end
  
  scenario 'User fails to create merchandise with invalid Flywire link' do
    visit new_merchandise_path
  
    fill_in 'Title', with: 'Sample Merchandise'
    fill_in 'Description', with: 'A new item'
    fill_in 'Link', with: 'https://invalid.link.com'
    click_button 'Submit' # Update to match button text in form
  
    expect(page).to have_content('Please enter a valid Flywire link.')
  end
  
  scenario 'User updates merchandise with valid data' do
    merchandise = create(:merchandise, title: 'Old Title', description: 'Old Description', link: 'https://tamu.estore.flywire.com/sample-link')
    visit edit_merchandise_path(merchandise)
  
    fill_in 'Title', with: 'Updated Title'
    fill_in 'Description', with: 'Updated Description'
    fill_in 'Link', with: 'https://tamu.estore.flywire.com/updated-link'
    click_button 'Submit' # Update to match button text in form
  
    expect(page).to have_content('Merchandise was successfully updated.')
    expect(page).to have_content('Updated Title')
    expect(page).to have_content('Updated Description')
  end
  
  scenario 'User fails to update merchandise with invalid Flywire link' do
    merchandise = create(:merchandise, title: 'Old Title', description: 'Old Description', link: 'https://tamu.estore.flywire.com/sample-link')
    visit edit_merchandise_path(merchandise)
  
    fill_in 'Link', with: 'https://invalid.link.com'
    click_button 'Submit' # Update to match button text in form
  
    expect(page).to have_content('Please enter a valid Flywire link.')
  end
  

scenario 'Officer deletes an existing merchandise item' do
    merchandise = create(:merchandise, title: 'To Be Deleted', description: 'A delete test', link: 'https://tamu.estore.flywire.com/delete-test')
    visit merchandises_path

    find('.delete-button', visible: :all).click 
    find('.confirm-delete-button').click

    expect(page).to have_content('Merchandise was successfully destroyed.')
    expect(page).not_to have_content('To Be Deleted')
  end
  
end
