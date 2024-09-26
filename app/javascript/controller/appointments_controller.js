import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="appointments"
export default class extends Controller {
  static targets = ["appointments"]

  connect() {
    this.subscription = createConsumer().subscriptions.create("AppointmentsChannel", {
      received: (data) => {
        this.appointmentsTarget.insertAdjacentHTML('afterbegin', data)
      }
    })
  }

  disconnect() {
    this.subscription.unsubscribe()
  }
}
