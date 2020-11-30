import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["results", "game", "platform", "genre"];

  showCards() {
    // e.preventDefault()
    const game = this.gameTarget.value;
    const platformId = this.platformTarget.value;
    const genreId = this.genreTarget.value
    // fetch(`/user?game=${game}&platform=${platformId}`, { headers: { accept: "application/json"} })
    //   .then(response => response.json())
    //   .then((data) => {
    //     this.resultsTarget.innerHTML = data.card_html;

    //   })

    async function loadCard(game, platformId, genreId) {
        const result = await fetch(`/user?game=${game}&platform=${platformId}&genre=${genreId}`, { headers: { accept: "application/json"} })
        return result.json()
    }

    loadCard(game, platformId, genreId)
      .then(data => {
        this.resultsTarget.innerHTML = data.card_html;
      });

    this.platformTarget.value = "";
    this.genreTarget.value = "";
  };

}
