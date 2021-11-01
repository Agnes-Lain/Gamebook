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

  def index
    # get the user games id array according to the user_id
    user_games = UserGame.where(user: current_user)
    authorize user_games
    # Mapping each game_id from the array and stock the json result after request the api call for game details
    @my_games = user_games.map do |game|
      HTTParty.get("https://api.rawg.io/api/games/#{game.rawg_game_id}?key=#{ENV['RAWG_API_KEY']}")
    end
    # check if the API call limits is reached, if so, game list return to empty, otherwise keep the filled game list
    if @my_games[0]["error"]
      @my_games = []
    end
    # initiate an empty game array
    @games = []
    # The following condition means to check if we should push standard game recommendation or personalised recommendation
    if user_games.empty?
      # if no user records, we call the rawg API to get standard game suggestions from their recommendations
      @games = HTTParty.get(ApplicationController::URL)["results"][0..11]
      # check if the API has error, if so, keep the game list empty
      if @games[0]["error"]
        @games = []
      end
    else
      # if we have the user collections, we then call our python recommendation fast_api to make collection prediction
      # following is to transfer the user games to params in order to send to Python API
      games = []
      user_games.each { |game| games.push({game_id: game.rawg_game_id,
                                          user_rating: 4
                                          })}
      params = { games: games }

      api_url = "https://batch-552-game-one-p275zsri5a-ew.a.run.app/user_pred_games"
      response = HTTParty.post(
        api_url,
        body: params.to_json,
        headers: { 'Content-Type' => 'application/json' }
      )
      # following is to check if the API reponse is positive or not
      if response.code == 200
        reco_game_ids = response['game_id'].values
        # if the response is positive and we get the list of games recommended
        # for each new recommendation, we can rawg API to get game json file and stock into @games
        reco_game_ids[0, 9].each do |id|
          url_game = "https://api.rawg.io/api/games/#{id}?key=#{ENV['RAWG_API_KEY']}"
          @games.push(HTTParty.get(url_game))
        end
        # check rawg API limiation error again
        if @games[0]["error"]
          @games = []
        end
      end
    end
  end

  private

  def game_params
    params.require(:game).permit(:rawg_game_id, :game_name)
  end

end
