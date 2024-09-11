// Este código deve estar em um arquivo separado, por exemplo, 'setupCalendar.js', que é importado com type="module"

import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import timeGridPlugin from '@fullcalendar/timegrid';
import interactionPlugin from '@fullcalendar/interaction';


document.addEventListener('DOMContentLoaded', function() {
  var calendarEl = document.getElementById('calendar');

  if (calendarEl) {
    var calendar = new Calendar(calendarEl, {
      plugins: [dayGridPlugin, timeGridPlugin, interactionPlugin],
      initialView: 'dayGridMonth',
      headerToolbar: {
        left: 'prev,next today',
        center: 'title',
        right: 'dayGridMonth,timeGridWeek,timeGridDay'
      },
      editable: true,
      selectable: true,
      businessHours: true,
      dayMaxEvents: true,
      events: [
        { title: 'Evento 1', start: '2024-09-10', end: '2024-09-12' },
        { title: 'Evento 2', start: '2024-09-13T10:00:00', end: '2024-09-13T12:00:00' }
      ]
    });
    calendar.render();
  } else {
    console.error("Elemento do calendário não encontrado!");
  }
});
