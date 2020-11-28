class UserPlatformsController < ApplicationController
  before_action :authenticate_user!

  def create
    # if UserConsole.find_by rawg_platform_id(platform_params) !=true
      @user_platform = UserPlatform.new(platform_params)
      @user_platform.user_id = current_user.id
      authorize @user_platform
      if @user_platform.save
        respond_to do |format|
          format.html { render }
          format.json {
            render json: { success: true }
          }
        end
      else
        render json: { success: false, errors: user_platform.errors.messages }, status: :unprocessable_entity
      end
    # end
  end

  def platform_params
    params.require(:platform).permit(:rawg_platform_id)
  end

end
