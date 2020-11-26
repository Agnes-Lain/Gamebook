class UserGamesController < ApplicationController
  def create
    raise
    @user_game = UserGame.new(user_id: params['user_id'])
    @game = Game.new
  end
end
