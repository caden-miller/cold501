require "rails_helper"

RSpec.describe LeaderboardCategoriesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/leaderboard_categories").to route_to("leaderboard_categories#index")
    end

    it "routes to #new" do
      expect(get: "/leaderboard_categories/new").to route_to("leaderboard_categories#new")
    end

    it "routes to #show" do
      expect(get: "/leaderboard_categories/1").to route_to("leaderboard_categories#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/leaderboard_categories/1/edit").to route_to("leaderboard_categories#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/leaderboard_categories").to route_to("leaderboard_categories#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/leaderboard_categories/1").to route_to("leaderboard_categories#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/leaderboard_categories/1").to route_to("leaderboard_categories#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/leaderboard_categories/1").to route_to("leaderboard_categories#destroy", id: "1")
    end
  end
end
