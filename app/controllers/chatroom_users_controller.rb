class ChatroomUsersController < ApplicationController
  include HtmlRender
  before_action :authenticate_user!
  before_action :set_chatroom
  # skip_before_action :verify_authorized
  skip_after_action :verify_authorized

  def show

  end

  def create
    chatroom_user = @chatroom.chatroom_users.where(user_id:current_user.id).first_or_create
    set_friend
    chatroom_user2 = @chatroom.chatroom_users.where(user_id:@friend.id).first_or_create
      respond_to do |format|
        format.html { render }
        format.json {
          render json: {
            hatroom_html: render_html_content(partial: "../chatrooms/chatroom", layout: false, locals: { chatroom: @chatroom })
          }
        }
      end
  end

  private

  def set_chatroom
    @chatroom = Chatroom.find(params[:chatroom_id])
  end

  def set_friend
    @friend = User.find(params[:friends][:friend_user_id].to_i)
  end
end
