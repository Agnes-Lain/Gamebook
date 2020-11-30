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
        // build an async function with one (platform) parameter to post data into user_platforms and user_games tables, then get back the new
        // record ids from both table and to fetch post to create new record into the 3rd game_platform table.
        async function saveGamePlatform (platform) {

          // fetch post data to user_platforms table and stock the response into a variable
          const resPlatform = await fetchWithToken(`/users/${platform.dataset.user}/user_platforms`, {
            method: "POST",
            headers: {
              "Accept": "application/json",
              "Content-Type": "application/json"
            },
            body: JSON.stringify({ platform: { rawg_platform_id: platform.id.split("-")[1], platform_name: platform.dataset.platform } })
          });

          // fetch post data to user_games table and stock the response into a variable
          const resGame = await fetchWithToken(`/users/${platform.dataset.user}/user_games`, {
            method: "POST",
            headers: {
              "Accept": "application/json",
              "Content-Type": "application/json"
            },
            body: JSON.stringify({ game: { rawg_game_id: platform.id.split("-")[0], game_name: platform.dataset.game } })
          });

          // define two new variable to stock the response in json from the above two.
          const userPlatform = await resPlatform.json();
          const userGame = await resGame.json();

          // defin a new function to fetch the 3rd table with the result from the above two.
          async function resGamePlatform (userPlatform, userGame) {
            const finalRes = await fetchWithToken(`/user_game_user_platforms`, {
              method: "POST",
              headers: {
                "Accept": "application/json",
                "Content-Type": "application/json"
              },
              body: JSON.stringify({ game_platform: { userPlatform, userGame } })
            });
            const response = await finalRes.json();
            return response
          }

          // call the above function with the two variables which stocked the response from the above two fetches,
          // and stock the result into a viarable finalRes as final result.

          const finalResponse = await resGamePlatform (userPlatform, userGame);
          return finalResponse;

        }

        // call the async function and out put the final data.
        saveGamePlatform (platform)
          .then(data => {
            alert(data.notice)
          });

        platform.checked = false;

      })
    }
  }
}
