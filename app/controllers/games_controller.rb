class GamesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :show ]
  skip_after_action :verify_authorized, only: [ :show ]

  def show
    url = "https://api.rawg.io/api/games/" + params[:id]
    @response = HTTParty.get(url)

    api_url = "https://batch-552-game-one-p275zsri5a-ew.a.run.app/pred_games?game_id=#{params[:id]}"
    reco_game_ids = HTTParty.get(api_url)['index'].values

    @games = []

    reco_game_ids.each do |id|
      url_game = "https://api.rawg.io/api/games/#{id}"
      @games.push(HTTParty.get(url_game))
    end
  end

end
