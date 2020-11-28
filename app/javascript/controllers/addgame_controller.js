import { Controller } from "stimulus"
import { fetchWithToken } from "../utils/fetch_with_token";

export default class extends Controller {
  static targets = [ "platform", "gameid"]

  saveGame(e) {
    e.preventDefault();
    const platforms = this.platformTargets.filter( platform => platform.checked === true);
    if (platforms.length === 0) {
      alert("You have to choose a game platform first to add a game to collection! Click the platform button to choose.");
    } else {
      platforms.forEach (platform => {
        // begin fetch to post data to create user_platforms
        fetchWithToken(`/users/${platform.dataset.user}/user_platforms`, {
          method: "POST",
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
          body: JSON.stringify({ platform: { rawg_platform_id: platform.id.split("-")[1] } })
        })
          .then(response => response.json())
          .then((data) => {
            console.log(data)
          }
        )
        // end of user_platforms fetch

        // begin fetch to post game data to create user_games
        fetchWithToken(`/users/${platform.dataset.user}/user_games`, {
          method: "POST",
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
          body: JSON.stringify({ game: { rawg_game_id: platform.id.split("-")[0] } })
        })
          .then(response => response.json())
          .then((data) => {
            console.log(data)
          }
        )
        // end of user_game fetch

      })
    }
  }
}
