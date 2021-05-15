class Message < ApplicationRecord
  belongs_to :chatroom

  validates :author, :content, presence: true
end
