# frozen_string_literal: true

# HomeController
class HomeController < ApplicationController
  before_action :set_user, :role, :set_navbar_variables
  def index; end
end
