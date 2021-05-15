class User < ApplicationRecord
  validates :status, :nickname, presence: true
  validates :nickname, uniqueness: true
  validates :status, inclusion: { in: %w[Available Busy Away], message: 'Status should be Available, Busy or Away' }
end
