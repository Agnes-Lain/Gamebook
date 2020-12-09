class ChatroomsController < ApplicationController
  include HtmlRender
  before_action :authenticate_user!

  def create
    rooms1 = current_user.chatroom_users.map {|e| e.chatroom_id}
    rooms2 = User.find(params[:friend_user_id].to_i).chatroom_users.map {|e| e.chatroom_id}
    room = rooms1 & rooms2
    if room.length > 0
      @chatroom = Chatroom.find(room.first)
      authorize @chatroom
      respond_to do |format|
        format.html { render }
        format.json {
          render json: {
            chatroom_html: render_html_content(partial: "chatroom", layout: false, locals: { chatroom: @chatroom })
          }
        }
      end
    else
      @chatroom = Chatroom.new(name: User.find(params[:friend_user_id].to_i).user_name)
      authorize @chatroom
      @chatroom.save
      respond_to do |format|
        format.html { render }
        format.json {
          render json: { success: true, chatroom_id: @chatroom.id }
        }
      end

    end

  end

  private

  # def chatroom_params
  #   params.require(:firend_user_id).permit(:firend_user_id)
  # end

end
