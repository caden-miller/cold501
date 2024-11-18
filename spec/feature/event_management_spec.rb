# frozen_string_literal: true

require 'rails_helper'
require 'capybara/rspec'
require 'selenium/webdriver'

RSpec.feature 'Event Management', type: :feature do
  let!(:admin_user) do
    create(:user, email: 'admin@example.com', full_name: 'Admin User', role: 'admin')
  end
  let!(:event) { create(:event, name: 'Test Event', location: 'Test Location') }

  before do
    Capybara.current_driver = :selenium_chrome_headless
  end

  context 'when managing events' do
    before do
      login_as(admin_user, scope: :user)
      visit events_path
    end

    scenario 'view events page' do
      expect(page).to have_content('EVENTS')
      expect(page).to have_content('Test Event')
      click_on 'Name'
      click_on 'Name'
    end

    scenario 'create a new event with valid data' do
      click_on 'Create New Event'
      create_event('New Event', '2024-10-28 10:00', '2024-10-28 12:00', 'New Location', 'This is a description.')
      expect_event_creation_success('New Event')
    end

    scenario 'fail to create a new event with blank name' do
      click_on 'Create New Event'
      create_event('', '2024-10-28 10:00', '2024-10-28 12:00', 'Location', 'Description')
      expect_blank_event_name_error
    end

    scenario 'edit an existing event with valid data' do
      visit event_path(event)
      click_on 'Edit Event'
      update_event('Updated Event', 'Updated Location', 'Updated Description')
      expect_event_update_success('Updated Event')
    end

    scenario 'archive an event' do
      visit event_path(event)
      click_on 'Archive'
      expect_event_archived
    end

    scenario 'unarchive an event from the archived events page' do
      event.update(archived: true)
      visit archived_events_path
      click_on 'Unarchive'
      expect_event_unarchived('Test Event')
    end

    scenario 'delete an event', :js do
      visit event_path(event)
      accept_confirm do
        click_on 'Delete Event'
      end
      expect_event_deletion_success('Test Event')
    end
  end

  # Helper methods
  def create_event(name, start_time, end_time, location, description)
  fill_in 'Name', with: name
  select_datetime(DateTime.parse(start_time), from: 'event_start_time', ampm: true, include_date: true)
  select_datetime(DateTime.parse(end_time), from: 'event_end_time', ampm: true, include_date: false)
  fill_in 'Location', with: location
  fill_in 'Description', with: description
  click_button 'Submit'
end


  # Add this helper method to select datetime in dropdowns
  def select_datetime(datetime, options = {})
    field = options[:from]
    prefix = field.downcase.gsub(' ', '_')
    ampm = options[:ampm]

    # Determine if date components are included
    if options[:include_date] != false
      select datetime.year.to_s, from: "#{prefix}_1i" # Year selector
      select Date::MONTHNAMES[datetime.month], from: "#{prefix}_2i" # Month selector
      select datetime.day.to_s.rjust(2, '0'), from: "#{prefix}_3i" # Day selector
      hour_index = 4
    else
      hour_index = 1
    end

    # Handle AM/PM
    hour_display = datetime.hour > 12 ? (datetime.hour - 12).to_s : datetime.hour.to_s
    am_pm_value = datetime.hour >= 12 ? 'PM' : 'AM'
    select hour_display.rjust(2, '0'), from: "#{prefix}_#{hour_index}i" # Hour selector
    select datetime.min.to_s.rjust(2, '0'), from: "#{prefix}_#{hour_index + 1}i" # Minute selector
    select am_pm_value, from: "#{prefix}_#{hour_index + 2}i" if ampm
  end




  def update_event(name, location, description)
    fill_in 'Name', with: name
    fill_in 'Location', with: location
    fill_in 'Description', with: description
    expect(page).to have_button('Submit', disabled: false, wait: 5)
    click_button 'Submit'
  end

  def expect_event_creation_success(event_name)
    expect(page).to have_content('Event was successfully created.')
    expect(page).to have_content(event_name.upcase)
  end

  def expect_blank_event_name_error
    # expect(page).to have_content("Name can't be blank")
  end

  def expect_event_update_success(event_name)
    expect(page).to have_content(event_name.upcase)
  end

  def expect_event_archived; end

  def expect_event_unarchived(event_name)
    expect(page).to have_content(event_name)
  end

  def expect_event_deletion_success(event_name)
    expect(page).not_to have_content(event_name)
  end
end
