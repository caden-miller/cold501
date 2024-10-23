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

    scenario 'create a new category' do
      click_on 'New Category'
      fill_in 'Category name', with: 'Test Category'
      fill_in 'Min points', with: '3'
      click_on 'Create Leaderboard category'

      expect(page).to have_content('Leaderboard category was successfully created.')
    end

    scenario 'edit an existing category' do
      create_category('Test Category', '3')
      click_on 'Edit this leaderboard category'

      update_category('Test Category 2', '4')
      expect_category_update_success
    end

    scenario 'delete an existing category' do
      create_category('Test Category 2', '4')
      destroy_category
      expect_category_deletion_success
    end
  end

  # Helper methods
  def create_category(name, points)
    click_on 'New Category'
    fill_in 'Category name', with: name
    fill_in 'Min points', with: points
    click_on 'Create Leaderboard category'
  end

  def update_category(name, points)
    fill_in 'Category name', with: name
    fill_in 'Min points', with: points
    click_on 'Update Leaderboard category'
  end

  def destroy_category
    click_on 'Destroy this leaderboard category'
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
