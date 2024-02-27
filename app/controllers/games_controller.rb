class GamesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :show ]
  skip_after_action :verify_authorized, only: [ :show ]

  def show
    url = "https://api.rawg.io/api/games/#{params[:id]}?key=#{ENV['RAWG_API_KEY']}"
    @response = HTTParty.get(url)
    if @response.code != 200
      @response = []
    end

    api_url = "https://batch-552-game-one-p275zsri5a-ew.a.run.app/pred_games?game_id=#{params[:id]}?key=#{ENV['GOOGLE_KEY']}"
    res = HTTParty.get(api_url)
    if res.code == 200
      reco_game_ids = res['index'].values

      @games = []

      reco_game_ids.each do |id|
        url_game = "https://api.rawg.io/api/games/#{id}?key=#{ENV['RAWG_API_KEY']}"
        @games.push(HTTParty.get(url_game))
      end
      if @games.length == 0
         @games = []
      end
    end
  end

end
