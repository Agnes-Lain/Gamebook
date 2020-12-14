class Message < ApplicationRecord
  belongs_to :chatroom, inverse_of: :messages
  belongs_to :user
  validates :content, presence: true
end
