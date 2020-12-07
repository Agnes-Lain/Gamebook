class UsersController < ApplicationController
  before_action :set_user, only: [:add_friend, :un_friend]
  skip_before_action :authenticate_user!
  before_action :skip_authorization
  # skip_before_action :verify_authorized

  # def index
  #   @users = User.where.not(id: current_user.id)
  # end

  def add_friend
    if current_user.add_friend(@user.id)
      # respond_to do |format|
      #   format.html { redirect_to user_root_path }
      #   format.js
      # end
      redirect_to user_root_path
    end
  end

  def un_friend
    if current_user.un_friend(@user.id)
      # respond_to do |format|
      #   format.html { redirect_to user_root_path }
      #   format.js
      # end
      redirect_to user_root_path
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

end
