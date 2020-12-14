class ChatroomChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    # chatroom = Chatroom.find(params[:id])
    # stream_for chatroom

    stop_all_streams
    @chatroom = Chatroom.find(params["id"].to_i)
    @chatroom_user = @chatroom.users
    stream_for @chatroom
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    stop_all_streams
  end

  # def touch
  #   @channel_user.touch(:last_read_at)
  # end
end
