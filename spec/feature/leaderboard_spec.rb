# frozen_string_literal: true

require 'rails_helper'
require 'capybara/rspec'
require 'selenium/webdriver'

RSpec.feature 'Leaderboard Management', type: :feature do
  let!(:user) do
    create(:user, email: 'testuser@example.com', full_name: 'Test User', role: 'admin', committee: 'Test Committee',
                  avatar_url: 'https://developers.google.com/static/workspace/chat/images/chat-product-icon.png')
  end

  context 'when managing leaderboard categories' do
    before do
      login_as(user, scope: :user)
      visit leaderboard_categories_path
    end

    scenario 'view categories page' do
      expect(page).to have_content('Categories')
    end

    scenario 'create a new category with valid data' do
      create_category('Test Category', '3')
      expect_category_creation_success
    end

    scenario 'fail to create a new category with blank name' do
      create_category('', '3')
      expect_blank_category_name_error
    end

    scenario 'fail to create a new category with blank points' do
      create_category('Test Category', '')
      expect_blank_min_points_error
    end

    scenario 'edit an existing category with valid data' do
      create_category('Test Category', '3')
      find('.table-button.edit').click

      update_category('Test Category 2', '4')
      expect_category_update_success
    end

    scenario 'fail to update a category with blank name' do
      create_category('Test Category', '3')
      find('.table-button.edit').click

      update_category('', '4')
      expect_blank_category_name_error
    end

    scenario 'fail to update a category with blank points' do
      create_category('Test Category', '3')
      find('.table-button.edit').click

      update_category('Test Category', '')
      expect_blank_min_points_error
    end

    scenario 'delete an existing category' do
      create_category('Test Category 2', '4')
      destroy_category
      expect_category_deletion_success
    end

    # Additional failure handling scenarios
    scenario 'fails to create category and triggers handle_create_failure' do
      create_category('', '') # Empty fields to trigger create failure
      expect(page).to have_content("Category name can't be blank")
      expect(page).to have_content("Min points can't be blank")
    end

    scenario 'fails to update category and triggers handle_update_failure' do
      create_category('Initial Category', '5')
      find('.table-button.edit').click

      update_category('', '') # Empty fields to trigger update failure
      expect(page).to have_content("Category name can't be blank")
      expect(page).to have_content("Min points can't be blank")
    end

    describe '#color_is_dark?' do
      it 'returns true for a dark color' do
        category = LeaderboardCategory.new(color: '000000') # Black
        expect(category.color_is_dark?).to be true
      end

      it 'returns false for a light color' do
        category = LeaderboardCategory.new(color: 'FFFFFF') # White
        expect(category.color_is_dark?).to be false
      end

      it 'returns true for a moderately dark color' do
        category = LeaderboardCategory.new(color: '333333') # Dark gray
        expect(category.color_is_dark?).to be true
      end

      it 'returns false for a moderately light color' do
        category = LeaderboardCategory.new(color: 'AAAAAA') # Light gray
        expect(category.color_is_dark?).to be false
      end
    end
  end

  # Helper methods
  def create_category(name, points)
    if page.has_link?('New Category') # Check if the link exists
      click_on 'New Category'
    else
      raise "Unable to find 'New Category' link"
    end

    fill_in 'Category name', with: name
    fill_in 'Min points', with: points
    click_button_with_image # Click the image button instead of a text button
  end

  def update_category(name, points)
    fill_in 'Category name', with: name
    fill_in 'Min points', with: points
    click_button_with_image # Click the image button to submit the form
  end

  def click_button_with_image
    find('button.table-button.confirm').click # Click the image button by its class
  end

  def destroy_category
    find('.table-button.trash').click
  end

  def expect_category_creation_success
    expect(page).to have_content('Leaderboard category was successfully created.')
  end

  def expect_blank_category_name_error
    expect(page).to have_content("Category name can't be blank")
  end

  def expect_blank_min_points_error
    expect(page).to have_content("Min points can't be blank")
  end

  def expect_category_update_success
    expect(page).to have_content('Leaderboard category was successfully updated.')
  end

  def expect_category_deletion_success
    expect(page).to have_content('Leaderboard category was successfully destroyed.')
    expect(page).to have_content('Categories')
    expect(page).not_to have_content('Test Category 2')
  end
end
