class PagesController < ApplicationController
  include HtmlRender
  skip_before_action :authenticate_user!, only: [ :home ]
  skip_after_action :verify_authorized, only: [:home, :dashboard]

  NOWDATE = Time.now.to_date.to_s
  LASTDATE = (NOWDATE.to_date - 183).to_s
  URL = "https://api.rawg.io/api/games?dates=#{LASTDATE},#{NOWDATE}&ordering=-added"

  def home
    @responses = HTTParty.get(URL)["results"][0..11]
  end

  def dashboard
    platforms1 = HTTParty.get("https://api.rawg.io/api/platforms?ordering=name")["results"]
    platforms2 = HTTParty.get("https://api.rawg.io/api/platforms?ordering=name&page=2")["results"]
    @platforms = ["Choose a platform"] + (platforms1 + platforms2).map{ |platform| [platform["name"], platform["id"]] }
    @user = current_user
    @user_platforms = UserPlatform.all
    # this is the API to answer the fetch from the stimulus #search controller and send back the result
    if params[:game].present? && params[:platform].present?
      game_name = params[:game]
      platform_id = params['platform'].to_i
      @search_results = HTTParty.get("https://api.rawg.io/api/games?search=#{game_name}&platforms=#{platform_id}&ordering=-released")["results"]
    elsif params[:game].present?
      game_name = params[:game]
      @search_results = HTTParty.get("https://api.rawg.io/api/games?search=#{game_name}")["results"]
    elsif params[:platform].present?
      platform_id = params[:platform].to_i
      @search_results = HTTParty.get("https://api.rawg.io/api/games?ordering=-released&platforms=#{platform_id}")["results"]
    else
      @search_results = HTTParty.get(URL)["results"][0..11]
    end
        # render json: {
        # # results: @search_results
        #   html_data: render_to_string(partial: "game_card", layout: false, locals: { responses: @search_results })
        # }

    respond_to do |format|
      format.html { render }
      format.json {
        render json: {
          card_html: render_html_content(partial: "game_card", layout: false, locals: { responses: @search_results })
        }
      }
    end
  end

  private


end
