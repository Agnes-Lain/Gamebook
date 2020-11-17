class GamesController < ApplicationController
  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    @user_game = UserGame.new
    @game_console = GameConsole.new
  end

  private

  def game_params
    params.require(:game).permit(:title, :release_date, :studio, :description, :age_limit, :is_online, :rawg_id, :console_model, :console_rawg_id, :genre_title, :genre_rawg_id)
  end
end
