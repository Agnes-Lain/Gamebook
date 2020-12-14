class Chatroom < ApplicationRecord
  has_many :messages, dependent: :destroy,
                      inverse_of: :chatroom
  has_many :chatroom_users, dependent: :destroy, inverse_of: :chatroom
  has_many :users, through: :chatroom_users
end
