class PagesController < ApplicationController
  include HtmlRender
  skip_before_action :authenticate_user!, only: [ :home ]
  skip_after_action :verify_authorized, only: [ :home ]
  before_action :get_games_count, :load_platforms, :load_game_genres


  def home
    @responses = HTTParty.get(ApplicationController::URL)["results"][0..11]
    game_search_results(params)
  end

  def dashboard
    load_user_platforms
    load_user_games
    load_user_friends

    game_search_results(params)
  end

  private

  def load_platforms
    platforms1 = HTTParty.get("https://api.rawg.io/api/platforms?key=#{ENV['RAWG_API_KEY']}&ordering=name")["results"]
    platforms2 = HTTParty.get("https://api.rawg.io/api/platforms?key=#{ENV['RAWG_API_KEY']}&ordering=name&page=2")["results"]
    if platforms1 && platforms2
      @platforms = [["Choose a platform", ""]] + (platforms1 + platforms2).map{ |platform| [platform["name"], platform["id"]] }
    else
      @platforms =[]
    end
  end

  def load_user_platforms
    @user_platforms = UserPlatform.where(user: current_user)
  end

  def get_games_count
    @games_count = HTTParty.get("https://api.rawg.io/api/games?key=#{ENV['RAWG_API_KEY']}")["count"]
  end

  def load_game_genres
    game_genre = HTTParty.get("https://api.rawg.io/api/genres?key=#{ENV['RAWG_API_KEY']}")["results"]
    if !game_genre.nil?
      @genres = [["Game Type", ""]] + game_genre.map{ |genre| [genre["name"], genre["id"]]
    else
      @genres = [["Game Type", ""]]
    end
  end

  def load_user_games
    user_games = UserGame.where(user: current_user)
    @user_games = user_games.map do |game|
      HTTParty.get("https://api.rawg.io/api/games/#{game.rawg_game_id}?key=#{ENV['RAWG_API_KEY']}")
    end
    @user_games
  end

  def load_user_friends
    user_friends = current_user.friend_users
    @friends = []
    user_friends.each { |friend| @friends << friend if friend.is_friend?(current_user) }
    @friends
  end

  def game_search_results(params)
    base_url = "https://api.rawg.io/api/games?key=#{ENV['RAWG_API_KEY']}&search="

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

  def set_chatroom(friend_user_id)
    @chatroom = Chatroom.new
    @chatroom.name = ""
  end

end
