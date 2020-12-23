class GamesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :show ]
  skip_after_action :verify_authorized, only: [ :show ]

  def show
    url = "https://api.rawg.io/api/games/" + params[:id]
    @response = HTTParty.get(url)
  end
end
