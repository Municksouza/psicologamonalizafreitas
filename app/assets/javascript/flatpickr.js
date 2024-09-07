import flatpickr from "flatpickr";

// Initialize flatpickr on specific fields when the page loads
document.addEventListener('turbolinks:load', function() {
  flatpickr("[name='appointment[start_time]']", {
    enableTime: true,
    dateFormat: "Y-m-d H:i",
  });
  flatpickr("[name='appointment[end_time]']", {
    enableTime: true,
    dateFormat: "Y-m-d H:i",
  });
});
