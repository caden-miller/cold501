# frozen_string_literal: true

# The User class represents users of the application.
# Users can have different roles (admin, member, user) and can have associated photos, attendances, and ideas.
class User < ApplicationRecord
  ROLES = %w[admin member user].freeze

  validates :role, inclusion: { in: ROLES }
  validates :full_name, presence: true
  validates :email, presence: true, uniqueness: true

  has_many :photos, dependent: :destroy
  has_many :attendances, dependent: :destroy
  # has_many :ideas, dependent: :destroy

  # Ensure devise works with omniauth-google_oauth2
  devise :omniauthable, omniauth_providers: [:google_oauth2]

  # Create or find a user from Google OAuth data
  def self.from_google(email:, full_name:, uid:, avatar_url:)
    create_with(uid:, full_name:, avatar_url:, role: 'admin').find_or_create_by!(email:)
  end
end
