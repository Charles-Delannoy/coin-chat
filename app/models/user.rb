class User < ApplicationRecord
  validates :status, :nickname, presence: true
  validates :nickname, uniqueness: true
  validates :status, inclusion: { in: %w[Available Busy Away], message: 'Status should be Available, Busy or Away' }

  def self.generate_user
    nickname = generate_nickname
    User.new(nickname: nickname, status: 'Available')
  end

  private

  def self.generate_nickname
    nickname = Faker::Internet.user_name until uniq_nickname?(nickname)
    nickname
  end

  def self.uniq_nickname?(nickname)
    nickname && User.where(nickname: nickname).empty?
  end
end
