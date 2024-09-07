document.addEventListener('DOMContentLoaded', function() {
  var calendarEl = document.getElementById('calendar');

  if (calendarEl) {
    var calendar = new FullCalendar.Calendar(calendarEl, {
      initialView: 'dayGridMonth',  // Modo de visualização inicial do calendário
      selectable: true,  // Permite a seleção de datas
      editable: false,  // Desabilita a edição de eventos diretamente no calendário
      events: '/appointments/index_json',  // Caminho para buscar eventos em JSON

      // Configura a ação ao clicar em uma data
      dateClick: function(info) {
        var date = info.dateStr;
        var startTime = prompt('Enter the start time (YYYY-MM-DDTHH:MM):', date + 'T09:00');
        var endTime = prompt('Enter the end time (YYYY-MM-DDTHH:MM):', date + 'T10:00');

        if (startTime && endTime) {
          document.getElementById('appointment_start_time').value = startTime;
          document.getElementById('appointment_end_time').value = endTime;

          // Submete o formulário após configurar os horários
          document.getElementById('appointment_form').submit();
        }
      },

      // Configura a ação ao clicar em um evento existente
      eventClick: function(info) {
        window.location.href = info.event.url; // Redireciona para a URL do evento
      }
    });

    calendar.render();  // Renderiza o calendário na página
  }
});
