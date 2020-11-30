class UserGameUserPlatformsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user_game_user_platform = UserGameUserPlatform.new(
      user_platform_id: params[:game_platform][:userPlatform][:user_platform_id],
      user_game_id: params[:game_platform][:userGame][:user_game_id]
    )
    authorize @user_game_user_platform

    if @user_game_user_platform.save
      if params[:game_platform][:userPlatform][:success] && params[:game_platform][:userGame][:success]
        respond_to do |format|
          format.html { render }
          format.json {
            render json: { success: true, message: "A new game and a new platform have been added to your collection" }
          }
        end
      elsif params[:game_platform][:userPlatform][:success]
        respond_to do |format|
          format.html { render }
          format.json {
            render json: { success: true, message: "Your game has been added to a new platform" }
          }
        end
      else
        respond_to do |format|
          format.html { render }
          format.json {
            render json: { success: true, message: "Your new game has been added to your platform" }
          }
        end
      end
    else
      respond_to do |format|
        format.html { render }
        format.json {
          render json: { success: false, message: "This game exist already in your collecion, can't add again" }
        }
      end
    end

  end

  private

  def game_platform_params
    params.require(:game_platform).permit( :userPlatform, :userGame)
  end
end
