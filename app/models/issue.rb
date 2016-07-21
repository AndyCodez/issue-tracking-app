class Issue < ApplicationRecord
  belongs_to :user
  has_many :comments
  enum priority: { low: 0, medium: 1, high: 2 }
  enum status: { open: 0, inprogress: 1, resolved: 2, closed: 3 }
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :title, presence: true
  validates :description, presence: true, length: { minimum: 50 }
  validates :priority, presence: true

end
