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
    if params["game"].present? && params["platform"].present?
      game_name = params['game']
      platform_id = params['platform'].to_i
      @search_results = HTTParty.get("https://api.rawg.io/api/games?search=#{game_name}&platforms=#{platform_id}&ordering=-released")["results"]
    elsif params["game"].present?
      game_name = params['game']
      @search_results = HTTParty.get("https://api.rawg.io/api/games?search=#{game_name}&ordering=-released")["results"]
    elsif params["platform"].present?
      platform_id = params['platform'].to_i
      @search_results = HTTParty.get("https://api.rawg.io/api/games?ordering=-released&platforms=#{platform_id}")["results"]
    else
      @search_results = @responses
    end
    respond_to do |format|
      format.html
      format.json { render json: { results: @search_results }}
    end
  end

  private


end
