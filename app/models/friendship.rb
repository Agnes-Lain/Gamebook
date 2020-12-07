class Friendship < ApplicationRecord
  belongs_to :friend_user, foreign_key: 'friend_user_id', class_name: 'User'
  belongs_to :user, foreign_key: 'user_id', class_name: 'User'
end
