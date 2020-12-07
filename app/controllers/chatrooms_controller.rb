class ChatroomsController < ApplicationController
  def show
    @chatroom = Chatroom.find(params[:id])
  end

  def create
    @chatroom = Chatroom.new(params)
  end
end
