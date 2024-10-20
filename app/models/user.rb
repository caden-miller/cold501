# frozen_string_literal: true

class User < ApplicationRecord
  ROLES = %w[admin member officer user].freeze

  validates :role, inclusion: { in: ROLES }
  validates :full_name, presence: true
  validates :email, presence: true, uniqueness: true
  has_many :photos
  has_many :attendances, dependent: :destroy
  has_many :photos
  has_many :ideas

  # ensure devise works with omniauth-google_oauth2
  devise :omniauthable, omniauth_providers: [:google_oauth2]

  # create self from Google OAuth (from Pratik's guide)
  # TODO: change the default role from admin to member
  def self.from_google(email:, full_name:, uid:, avatar_url:)
    create_with(uid:, full_name:, avatar_url:, role: 'admin').find_or_create_by!(email:)
  end

  def admin?
    role == 'admin'
  end

  def officer?
    role == 'officer'
  end

  def member?
    role == 'member'
  end
end
