import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "userList", "name"]

  // connect() {
  //   setInterval(this.searchUser, 5000);
  // }

  searchUser(e) {
    e.preventDefault();
    const keyword = this.nameTarget.value
    fetch(`/user?query=${keyword}`, { headers: { accept: "application/json"} })
      .then(response => response.json())
      .then((data) => {
        this.userListTarget.innerHTML = data.users_html;
        this.nameTarget.value = ""
      })

  }
}
