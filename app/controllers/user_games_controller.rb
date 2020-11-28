class UserGamesController < ApplicationController
  before_action :authenticate_user!

  def create
    @user_game = UserGame.new(game_params)
    @user_game.user = current_user
    authorize @user_game

    # check if the save is true or not to avoid duplication of user vs game records in db
    if @user_game.save
      respond_to do |format|
        format.html { render }
        format.json {
          render json: { success: true, user_game_id: @user_game.id }
        }
      end
    else
      respond_to do |format|
        format.html { render }
        format.json {
          render json: { success: false, user_game_id: UserGame.where("user_id = ? AND rawg_game_id = ?", "#{current_user.id}", "#{game_params[:rawg_game_id]}")[0].id }
          # status: :unprocessable_entity
        }
     end
    end
    # end of the render to stimulus controller

  end

  private

  def game_params
    params.require(:game).permit(:rawg_game_id)
  end
end
