// Visit The Stimulus Handbook for more details
// https://stimulusjs.org/handbook/introduction
//
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>
import { fetchWithToken } from "../utils/fetch_with_token";
import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "output" ]

  friendRequest() {
    this.element.innerHTML = '<i class="fas fa-question-circle"></i>';
    const userId = this.element.parentElement.dataset.user;
    alert( 'You have sent a friend request!' )
    async function addFriend(userId) {
        const result = await fetchWithToken(`/users/${userId}/add_friend`,{
          method: "POST",
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
          body: JSON.stringify({ id: userId})
        });
        return result.json()
    }

    addFriend(userId)
      .then(data=>{
        if (data.success) {
          async function addNotice(userId) {
            const notice = await fetchWithToken(`/notifications`, {
              method: "POST",
              headers: {
                "Accept": "application/json",
                "Content-Type": "application/json"
              },
              body: JSON.stringify({ id: userId, type: 'friendship' })
            });
            return notice.json()
          }

          addNotice(userId)
            .then(data=>{
              console.log(data)
            })
        }

      });
  }
}
