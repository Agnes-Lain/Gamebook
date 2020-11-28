class UserPlatformsController < ApplicationController
  before_action :authenticate_user!
  # skip_after_action :verify_authorized, only: [:create]

  def create
    @user_platform = UserPlatform.new(platform_params)
    @user_platform.user = current_user
    authorize @user_platform

    # check if the save is true or not to avoid duplication of user vs platform records in db
    if @user_platform.save
      respond_to do |format|
        format.html { render }
        format.json {
          render json: { success: true, user_platform_id: @user_platform.id }
        }
      end
    else
      respond_to do |format|
        format.html { render }
        format.json {
          render json: { success: false, user_platform_id: UserPlatform.where("user_id = ? AND rawg_platform_id = ?", "#{current_user.id}", "#{platform_params[:rawg_platform_id]}")[0].id }
          # status: :unprocessable_entity
        }
      end
    end
    # end of the render to stimulus controller

  end

  def platform_params
    params.require(:platform).permit(:rawg_platform_id)
  end

end
