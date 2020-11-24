import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["results", "game", "platform"];

  showCards(e) {
    // e.preventDefault()
    const game = this.gameTarget.value;
    const platformId = this.platformTarget.value;
    fetch(`/dashboard?game=${game}&platform=${platformId}`, { headers: { accept: "application/json"} })
      .then(response => response.json())
      .then((data) => {
        let gamesHTML = "";
        const searchResults = data.results;
        searchResults.forEach(result => {
          gamesHTML += this.gameCard(result)
        });
        this.resultsTarget.innerHTML = gamesHTML;
      })
  };

  gameCard (game) {
    return `<div class="card">
      <img src =${game.background_image} class:"card-img-top" width="316" height="170">
      <div class="card-body">
        <h3 class="card-title">${game.name}</h3>
        <p class="card-text">rating: ${game.rating}</p>
        <p class="card-text">
        </p>
        <a href="#" class="btn btn-primary">Add to my collection</a>
      </div>

    </div>`
  }
}
