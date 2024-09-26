// import { Controller } from "@hotwired/stimulus";
// import flatpickr from "flatpickr";

// export default class extends Controller {
//   static values = {
//     bookedDates: Array
//   }

//   connect() {
//     console.log("Flatpickr connected!");

//     flatpickr(this.element, {
//       enableTime: true,
//       dateFormat: "Y-m-d H:i",
//       time_24hr: true,
//       minDate: "today",
//       altInput: true,
//       altFormat: "d-m-Y H:i",
//       allowInput: true,
//       disable: this.bookedDatesValue,
//       onChange: (selectedDates, dateStr) => {
//         console.log("Data alterada: ", dateStr);
//       },
//       onClose: (selectedDates, dateStr) => {
//         console.log("Flatpickr fechado: ", dateStr);
//       }
//     });
//   }
// }
