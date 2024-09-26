import flatpickr from "flatpickr";


document.addEventListener("DOMContentLoaded", () => {
  const datepicker = document.querySelector(".datepicker");
  if (datepicker) {
    const bookedDates = JSON.parse(datepicker.dataset.bookedDates || "[]");
    const availableDates = JSON.parse(datepicker.dataset.availableDates || "[]");

    flatpickr(".datepicker", {
      enableTime: false,  // Disable time selection
      dateFormat: "Y-m-d",  // Date format only
      minDate: "today",
      disable: bookedDates, // Disable booked dates
      altInput: true,
      allowInput: false,  // Disable manual input

      // Highlight both available and booked dates
      onDayCreate: function(dObj, dStr, fp, dayElem) {
        const dateStr = dayElem.dateObj.toISOString().split("T")[0]; // Format date to match booked/available dates

        if (bookedDates.includes(dateStr)) {
          dayElem.classList.add('booked-date');  // Add custom class to booked dates
        } else if (availableDates.includes(dateStr)) {
          dayElem.classList.add('available-date');  // Add custom class to available dates
        }
      }
    });
  }
});
