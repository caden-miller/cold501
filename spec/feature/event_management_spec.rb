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

    # Split 'view events page' scenario into two separate scenarios

    scenario 'displays the EVENTS heading' do
      expect(page).to have_content('EVENTS')
    end

    scenario 'displays existing events' do
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
    select_datetime(DateTime.parse(end_time), from: 'event_end_time', ampm: true, include_date: true)
    fill_in 'Location', with: location
    fill_in 'Description', with: description
    click_button 'Submit'
  end

  def select_datetime(datetime, options = {})
    field = options[:from]
    ampm = options[:ampm]
    include_date = options.fetch(:include_date, true)
    prefix = field.downcase.gsub(' ', '_')

    within("##{prefix}") do
      select_date(datetime, prefix, include_date)
      select_time(datetime, prefix, ampm)
    end
  rescue StandardError => e
    Rails.logger.error("Error selecting datetime: #{e.message}")
  end

  def select_date(datetime, prefix, include_date)
    return unless include_date

    select_year(datetime.year, from: "#{prefix}_1i")
    select_month(datetime.month, from: "#{prefix}_2i")
    select_day(datetime.day, from: "#{prefix}_3i")
  end

  def select_year(year, from:)
    select year.to_s, from:
  end

  def select_month(month, from:)
    select Date::MONTHNAMES[month], from:
  end

  def select_day(day, from:)
    select day.to_s.rjust(2, '0'), from:
  end

  def select_time(datetime, prefix, ampm)
    hour = calculate_hour(datetime.hour, ampm)
    minute = datetime.min.to_s.rjust(2, '0')
    period = ampm ? determine_period(datetime.hour) : nil

    select_hour(prefix, hour)
    select_minute(prefix, minute)
    select_period(prefix, period) if ampm && has_selector?("select##{prefix}_6i")
  end

  def calculate_hour(hour, ampm)
    return 12 if ampm && (hour % 12).zero?

    ampm ? (hour % 12) : hour
  end

  def determine_period(hour)
    hour < 12 ? 'AM' : 'PM'
  end

  def select_hour(prefix, hour)
    select hour.to_s.rjust(2, '0'), from: "#{prefix}_4i"
  end

  def select_minute(prefix, minute)
    select minute, from: "#{prefix}_5i"
  end

  def select_period(prefix, period)
    select period, from: "#{prefix}_6i"
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
    expect(page).to have_content("Name can't be blank")
  end

  def expect_event_update_success(event_name)
    expect(page).to have_content(event_name.upcase)
  end

  def expect_event_archived
    expect(page).to have_content('Event was successfully archived.')
    # Add more specific expectations if needed
  end

  def expect_event_unarchived(event_name)
    expect(page).to have_content(event_name)
    expect(page).to have_content('Event was successfully unarchived and restored to the main list.')
  end

  def expect_event_deletion_success(event_name)
    expect(page).not_to have_content(event_name)
    expect(page).to have_content('Event was successfully deleted.')
  end
end
