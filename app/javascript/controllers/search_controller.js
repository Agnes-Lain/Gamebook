import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["results", "game", "platform"];

  showCards() {
    // e.preventDefault()
    const game = this.gameTarget.value;
    const platformId = this.platformTarget.value;
    fetch(`/dashboard?game=${game}&platform=${platformId}`, { headers: { accept: "application/json"} })
      .then(response => response.json())
      .then((data) => {
        let gamesHTML = "";
        const searchResults = data.results;
        searchResults.forEach(result => {
          let platforms = result.platforms;
          let platformList = platforms.map(plat => plat.platform.name).join(" | ");
          const gameGenres = result.genres.map(genre => genre.name).join(" | ");
          gamesHTML += this.gameCard(result, platformId, platformList, gameGenres)
        });
        this.resultsTarget.innerHTML = gamesHTML;
      })
  };

  gameCard (game, platformId, platformList, gameGenres) {
    return `<div class="card" data-platform-id="${platformId}" data-game-id="${game.id}" data->
      <img src =${game.background_image === null ? "https://media.istockphoto.com/vectors/coming-soon-neon-banner-vector-template-glowing-night-bright-sign-vector-id1144514162?k=6&m=1144514162&s=612x612&w=0&h=np7sPl0hycuFTiDgfKCZFy3SF7XCjbRTcyF-sSKfMO8=" : game.background_image} class:"card-img-top" width="316" height="170">
      <div class="card-body">
        <h4 class="card-title">${game.name}</h4>
        <p class="card-text"><small>rating: ${game.rating}</small></p>
        <p class="game-release"><small>release date: ${game.released}</small></p>
        <p class="card-text">${platformList}</p>
        <p class="game-genres"><small>${gameGenres}</small></p>
        <a href="#" class="btn btn-primary">Add to my collection</a>
      </div>

    </div>`
  }
}
