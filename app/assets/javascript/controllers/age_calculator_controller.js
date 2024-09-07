import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["dob", "age"];

  connect() {
    this.calculateAge();
  }

  calculateAge() {
    const dob = new Date(this.dobTarget.value);
    const today = new Date();
    let age = today.getFullYear() - dob.getFullYear();
    const m = today.getMonth() - dob.getMonth();
    if (m < 0 || (m === 0 && today.getDate() < dob.getDate())) {
      age--;
    }
    this.ageTarget.textContent = `Age: ${age} years`;
  }
}
