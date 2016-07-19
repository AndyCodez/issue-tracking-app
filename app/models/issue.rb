class Issue < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :description, presence: true, length: { minimum: 50 }
end
