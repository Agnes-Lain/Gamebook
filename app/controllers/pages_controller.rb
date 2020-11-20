class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  NOWDATE = Time.now.to_date.to_s
  LASTDATE = (NOWDATE.to_date - 183).to_s
  URL = "https://api.rawg.io/api/games?dates=#{LASTDATE},#{NOWDATE}&ordering=-added"

  def home
    @responses = HTTParty.get(URL)["results"][0..11]
  end

  def dashboard
    @consoles = Console.all.sort.reverse
    @responses = HTTParty.get(URL)["results"][0..11]
    @user = current_user
    @user_games = @user.games
  end
end
