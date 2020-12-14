class MessagesController < ApplicationController

  def create
    @chatroom = Chatroom.find(params[:chatroom_id])
    @message = Message.new(message_params)
    @message.chatroom = @chatroom
    @message.user = current_user
    authorize @message
    # @message.save
    if @message.save
      ChatroomChannel.broadcast_to(
        @chatroom,
        render_to_string(partial: "message", locals: { message: @message })
      )
    else
      # render partical: 'error', comment: @comment, status: :bad_request
      respond_to do |format|
        # format.html { render }
        format.json {
          render json: { success: false, status: :bad_request }
        }
      end
    end

  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

end
