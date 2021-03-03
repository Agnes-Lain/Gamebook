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

  def show
    user_games = UserGame.all
    authorize user_games
    games = []
    user_games.each {|game| games.push({game_id: game.rawg_game_id,
                                        user_rating: 4
                                        })}
    params = {games: games}

    api_url = "https://game-one-project-p275zsri5a-ew.a.run.app/user_pred_games"
    reco_game_ids = HTTParty.post(
      api_url,
      body: params.to_json,
      headers: { 'Content-Type' => 'application/json' }
    )['game_id'].values


    @games = []

    reco_game_ids.each do |id|
      url_game = "https://api.rawg.io/api/games/#{id}"
      @games.push(HTTParty.get(url_game))
    end

  end

  private

  def game_params
    params.require(:game).permit(:rawg_game_id, :game_name)
  end
end
