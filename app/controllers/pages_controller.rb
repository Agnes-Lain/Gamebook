class PagesController < ApplicationController
  include HtmlRender
  skip_before_action :authenticate_user!, only: [ :home ]
  skip_after_action :verify_authorized, only: [ :home ]

  NOWDATE = Time.now.to_date.to_s
  LASTDATE = (NOWDATE.to_date - 183).to_s
  URL = "https://api.rawg.io/api/games?search=&dates=#{LASTDATE},#{NOWDATE}&ordering=-rating"

  def home
    @responses = HTTParty.get(URL)["results"][0..11]
  end

  def dashboard
    platforms1 = HTTParty.get("https://api.rawg.io/api/platforms?ordering=name")["results"]
    platforms2 = HTTParty.get("https://api.rawg.io/api/platforms?ordering=name&page=2")["results"]
    @platforms = [["Choose a platform", ""]] + (platforms1 + platforms2).map{ |platform| [platform["name"], platform["id"]] }
    @user = current_user
    @user_platforms = UserPlatform.all
    @user_games = UserGame.all

    @genres = [["Game Type", ""]]+ HTTParty.get("https://api.rawg.io/api/genres")["results"].map{ |genre| [genre["name"], genre["id"]] }

    # this is the API to answer the fetch from the stimulus #search controller and send back the result
    base_url = "https://api.rawg.io/api/games?search="

    search_array = []
    if params[:game].present?
      search_array << "#{params[:game]}"
    end
    if params[:platform].present?
      search_array << "&platforms=#{params['platform'].to_i}"
    end
    if params[:genre].present?
      search_array << "&genres=#{params['genre'].to_i}"
    end
    # search_array << "&ordering=-rating"

    final_url = base_url + search_array.join('')

    @search_results = HTTParty.get(final_url)["results"]

    respond_to do |format|
      format.html { render }
      format.json {
        render json: {
          card_html: render_html_content(partial: "game_card", layout: false, locals: { responses: @search_results })
        }
      }
    end
  end

end
