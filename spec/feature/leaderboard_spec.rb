require 'rails_helper'

require 'capybara/rspec'
require 'selenium/webdriver'

RSpec.feature 'Leaderboard', type: :feature do
    let!(:user) do
        create(:user, email: 'testuser@example.com', full_name: 'Test User', role: 'admin', committee: 'Test Committee',
                      avatar_url: 'https://developers.google.com/static/workspace/chat/images/chat-product-icon.png')
      end

    scenario 'View leaderboard, create new category, then edit it, and then delete it' do
        login_as(user, scope: :user)
        visit leaderboard_categories_path

        expect(page).to have_content('Categories')
        click_on 'New Category'
        fill_in 'Category name', with: 'Test Category'
        fill_in 'Min points', with: '3'
        click_on 'Create Leaderboard category'

        expect(page).to have_content('Leaderboard category was successfully created.')
        click_on 'Edit this leaderboard category'

        fill_in 'Category name', with: 'Test Category 2'
        fill_in 'Min points', with: '4'
        click_on 'Update Leaderboard category'

        click_on 'Destroy this leaderboard category'

        expect(page).to have_content('Leaderboard category was successfully destroyed.')
        expect(page).to have_content('Categories')
        expect(page).to_not have_content('Test Category 2')
    end
end