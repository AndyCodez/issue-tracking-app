class Issue < ApplicationRecord
  belongs_to :user
  enum priority: { low: 0, medium: 1, high: 2 }
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :title, presence: true
  validates :description, presence: true, length: { minimum: 50 }
  validates :priority, presence: true

end
