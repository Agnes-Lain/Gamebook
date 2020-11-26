import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "platform", "gameid"]

  saveGame(e) {
    e.preventDefault();
    console.log (this.platformTargets);
  }
}
