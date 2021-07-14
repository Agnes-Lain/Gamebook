class NotificationsController < ApplicationController
  # before_action :init_notice
  skip_before_action :authenticate_user!
  before_action :skip_authorization

  def create
    if params[:type] = 'friendship'
      @notice = Notification.new(user_id: params[:id].to_i)
      @notice.content = "#{current_user.user_name} has sent to you a friend request!"
      authorize @notice
      if @notice.save
        respond_to do |format|
          format.html { render }
          format.json {
            render json: { success: true }
          }
        end
      end

      # if @message.save
      #   ChatroomChannel.broadcast_to(
      #     @chatroom,
      #     render_to_string(partial: "message", locals: { message: @message })
      #   )
      # else
      #   # render partical: 'error', comment: @comment, status: :bad_request
      #   respond_to do |format|
      #     # format.html { render }
      #     format.json {
      #       render json: { success: false, status: :bad_request }
      #     }
      #   end
      # end

    end
  end

  def index
    @notifications = Notification.where(user: current_user.id)
    authorize @notifications
    @notifications
  end

  # private

  # def init_notice
  #   params.require(:notification).permit(:id, :type)
  #   # @user = User.find(params[:id].to_i)
  #   # @type = params[:type]
  # end
end
