import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["results", "game", "platform", "genre"];

  showCards(e) {
    e.preventDefault()
    const game = this.gameTarget.value;
    const platformId = this.platformTarget.value;
    const genreId = this.genreTarget.value


    async function loadCard(game, platformId, genreId) {
        const result = await fetch(`/?game=${game}&platform=${platformId}&genre=${genreId}`, { headers: { accept: "application/json"} })
        return result.json()
    }

    loadCard(game, platformId, genreId)
      .then(data => {
        this.resultsTarget.innerHTML = data.card_html;
      });
    // this.gameTarget.value = ""
    // this.platformTarget.value = "";
    // this.genreTarget.value = "";
  };

}
