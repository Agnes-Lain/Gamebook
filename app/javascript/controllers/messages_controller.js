import { Controller } from "stimulus";
import consumer from "channels/consumer";

export default class extends Controller {
  static targets = ["inputMes", "mes"]

  connect() {
    const room = this.mesTarget
    // console.log(room.dataset.chatroomid)
    this.subscription = consumer.subscriptions.create({ channel: "ChatroomChannel", id: `${room.dataset.chatroomid}` }, {
      connected: this._connected.bind(this),
      disconnected: this._disconnected.bind(this),
      received: this._received.bind(this)
    })
  }

  clearMes() {
    // console.log(this.inputMesTarget.value)
    this.inputMesTarget.value = '';
  }

  _connected() {
    // Called when the subscription is ready for use on the server
    // this.scrollToBottom()
  }

  _disconnected() {
    // Called when the subscription has been terminated by the server
  }

  _received(data) {
    // Called when there's incoming data on the websocket for this channel
    // this.messagesTarget.innerHTML += data.message;
    if (data) {
      this.mesTarget.insertAdjacentHTML('beforeend', data)
      this.scrollToBottom()

      // if (!document.hidden) {
      //   this.subscription.perform("touch")
      // }
    }
  }

  scrollToBottom() {
    const messageBox = document.getElementById("messages");
    messageBox.scrollTo(0, messageBox.scrollHeight)
  }

}



