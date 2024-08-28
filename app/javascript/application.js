// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import { createConsumer } from "@rails/actioncable"
const consumer = createConsumer()
export default consumer


document.addEventListener('DOMContentLoaded', function() {
  var calendarEl = document.getElementById('calendar');
  var calendar = new Calendar(calendarEl, {
    plugins: [ dayGridPlugin ],
    events: '/appointments.json'
  });
  calendar.render();
});

import "channels"
