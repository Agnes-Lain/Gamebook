class MessagesController < ApplicationController

  def create
    @chatroom = Chatroom.find(params[:chatroom_id])
    @message = Message.new(message_params)
    @message.chatroom = @chatroom
    @message.user = current_user
    authorize @message
    @message.save
    # if @message.save
    #   redirect_to user_root_path(anchor: "message-#{@message.id}")
    # else
    #   render "chatrooms/show"
    # end

    ChatroomChannel.broadcast_to(
      @chatroom,
      render_to_string(partial: "message", locals: { message: @message })
    )
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

end
