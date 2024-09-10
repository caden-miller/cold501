class User < ApplicationRecord
  has_secure_password

  def self.from_omniauth(response)
    User.find_or_create_by(uid: response[:uid], provider: response[:provider]) do |u|
      u.username = response[:info][:name]
      u.email = response[:info][:email]
      u.image = response[:info][:image]
      u.password = SecureRandom.hex(15)
    end
  end
end
