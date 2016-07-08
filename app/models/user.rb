class User < ApplicationRecord
  validates :username, presence: true, length: { maximum: 30}

  validates :email, presence: true, length: { maximum: 255 }

  has_secure_password

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                   BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
