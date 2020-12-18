class UsersController < ApplicationController
  include HtmlRender
  before_action :set_user, only: [:add_friend, :un_friend]
  skip_before_action :authenticate_user!
  before_action :skip_authorization
  # skip_before_action :verify_authorized

  def index
    if params[:query].nil?
      @searched_users = User.where.not(id: current_user.id)
      respond_to do |format|
        format.html { render }
        format.json {
          render json: {
            users_html: render_html_content(partial: "user", layout: false, locals: { users: @searched_users })
          }
        }
      end
    else
      load_users(params)
      respond_to do |format|
        format.html { render }
        format.json {
          render json: {
            users_html: render_html_content(partial: "user", layout: false, locals: { users: @searched_users })
          }
        }
      end
    end
  end

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

  def load_users(params)
    @searched_users = User.where("user_name ILIKE ? AND id != ?", "%#{params[:query]}%", "#{current_user.id}")
  end

end
