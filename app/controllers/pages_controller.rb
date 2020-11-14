require 'json'

class PagesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @responses = HTTParty.get('https://api.rawg.io/api/games?dates=2019-01-01,2019-12-31&ordering=-added')["results"][0..11]
  end

  def dashboard
    @user = current_user
    @consoles = @user.consoles
    @games = @user.games
  end
end
