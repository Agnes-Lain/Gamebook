class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # acts_as_token_authenticatable

  has_many :user_platforms, dependent: :destroy
  has_many :user_games, dependent: :destroy
  has_many :user_game_user_platforms, through: :user_games, dependent: :destroy
  has_many :chatroom_users, dependent: :destroy
  has_many :chatrooms, through: :chatroom_users
  has_many :messages


  has_many :friend_user_relationships, foreign_key: :user_id, class_name: 'Friendship'
  has_many :friend_users, through: :friend_user_relationships, source: :friend_user

  has_many :user_relationship, foreign_key: :friend_user_id, class_name: 'Friendship'
  has_many :users, through: :user_relationships, source: :user

  has_one_attached :photo

  def add_friend(user_id)
    friend_user_relationships.create(friend_user_id: user_id)

  end

  def un_friend(user_id)
    friend_user_relationships.find_by(friend_user_id: user_id).destroy
  end

  def is_friend?(user_id)
    relationship = Friendship.find_by(user_id: id, friend_user_id: user_id)
    return true if relationship
  end
end
