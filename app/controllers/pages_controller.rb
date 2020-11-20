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
    if params["search"].present? || params["platforms"].present?
      games = params['search']
      platform = params['platforms']
      platform_id = Console.where(console_model:platform).first.rawg_id
      @search_results = HTTParty.get("https://api.rawg.io/api/games?search=#{games}&platforms=#{platform_id}&ordering=-released")["results"][1..11]
      # respond_to do |format|
      #   format.html
      #   format.json { render json: { dashboard: @search_results }}
      # end
    end
  end

  private

  def search_params
    params.require(:games).permit(:search, :platforms)
  end

end
