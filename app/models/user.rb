class User < ApplicationRecord
  ROLES =%w[admin member officer user].freeze

  validates :role, inclusion: { in: ROLES }
  validates :full_name, presence: true 
  
  # ensure devise works with omniauth-google_oauth2
  devise :omniauthable, omniauth_providers: [:google_oauth2]
  
  # create self from Google OAuth (from Pratik's guide) 
  # TODO: change the default role from admin to member 
  def self.from_google(email:, full_name:, uid:, avatar_url:)
    create_with(uid: uid, full_name: full_name, avatar_url: avatar_url, role: 'admin').find_or_create_by!(email: email)
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
