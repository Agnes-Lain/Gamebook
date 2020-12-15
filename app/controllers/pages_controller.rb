class PagesController < ApplicationController
  include HtmlRender
  skip_before_action :authenticate_user!, only: [ :home ]
  skip_after_action :verify_authorized, only: [ :home ]
  before_action :get_games_count, :load_platforms, :load_game_genres

  NOWDATE = Time.now.to_date.to_s
  LASTDATE = (NOWDATE.to_date - 183).to_s
  URL = "https://api.rawg.io/api/games?search=&dates=#{LASTDATE},#{NOWDATE}&ordering=-rating"

  def home
    @responses = HTTParty.get(URL)["results"][0..11]
    # get_games_count
    # load_platforms
    # load_game_genres
    game_search_results(params)
  end

  def dashboard
    # get_games_count
    # load_platforms
    # load_game_genres
    load_user_platforms
    load_user_games
    load_user_friends

    # condition to trigger search of users
    if params[:query] == ""
      load_users(params)

      respond_to do |format|
        format.html { render }
        format.json {
          render json: {
            users_html: render_html_content(partial: "user", layout: false, locals: { users: @searched_users })
          }
        }
      end
    # condition to trigger search of games
    elsif params[:query].present?
      @searched_users = User.where.not(id: current_user.id)
      respond_to do |format|
        format.html { render }
        format.json {
          render json: {
            users_html: render_html_content(partial: "user", layout: false, locals: { users: @searched_users })
          }
        }
      end
    else
      game_search_results(params)

    end


  end

  private

  def load_platforms
    platforms1 = HTTParty.get("https://api.rawg.io/api/platforms?ordering=name")["results"]
    platforms2 = HTTParty.get("https://api.rawg.io/api/platforms?ordering=name&page=2")["results"]
    @platforms = [["Choose a platform", ""]] + (platforms1 + platforms2).map{ |platform| [platform["name"], platform["id"]] }
  end

  def load_user_platforms
    @user_platforms = UserPlatform.all
  end

  def get_games_count
    @games_count = HTTParty.get("https://api.rawg.io/api/games")["count"]
  end

  def load_game_genres
    @genres = [["Game Type", ""]]+ HTTParty.get("https://api.rawg.io/api/genres")["results"].map{ |genre| [genre["name"], genre["id"]] }
  end

  def load_users(params)
    @searched_users = User.where("user_name ILIKE ? AND id != ?", "%#{params[:query]}%", "#{current_user.id}")
  end

  def load_user_games
    user_games = UserGame.all
    @user_games = user_games.map do |game|
      HTTParty.get("https://api.rawg.io/api/games/#{game.rawg_game_id}")
    end
    @user_games
  end

  def load_user_friends
    @friends = current_user.friend_users
  end

  def game_search_results(params)
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

  def set_chatroom(friend_user_id)
    @chatroom = Chatroom.new
    @chatroom.name = ""
  end

end
