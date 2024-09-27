import "flatpickr";

document.addEventListener('DOMContentLoaded', function() {
  // Selecionar o elemento de data
  const datepicker = document.querySelector(".datepicker");
  const timeSelect = document.getElementById('timeSelect');
  const timeSlotContainer = document.getElementById('timeSlotContainer');
  const submitButton = document.getElementById('submitButton');

  // Verificar se o datepicker existe
  if (!datepicker) {
      console.log("Datepicker element not found on this page. Continuing without datepicker.");
      return;
  }

  // Verifique se os outros elementos para horários e botão foram encontrados
  if (!timeSelect || !timeSlotContainer || !submitButton) {
      console.log("timeSelect, timeSlotContainer, or submitButton element not found. Ignoring these elements.");
      // Como esses elementos não estão disponíveis, não vamos executar o código relacionado a eles.
      return;
  }

  // Obtenha os dados de datas disponíveis e reservadas
  const bookedDates = JSON.parse(datepicker.dataset.bookedDates || "[]");
  const availableDates = JSON.parse(datepicker.dataset.availableDates || "[]");

  console.log('Available Dates:', availableDates);
  console.log('Booked Dates:', bookedDates);

  // Inicializar o Flatpickr
  flatpickr(datepicker, {
      enableTime: false,  // Desativar a seleção de hora inicialmente
      dateFormat: "d/m/Y",  // Formato de data no padrão brasileiro
      minDate: "today",  // Impedir a seleção de datas passadas
      disable: bookedDates.map(date => new Date(date)),  // Desabilitar datas reservadas
      time_24hr: true,  // Usar formato de 24 horas

      // Evento para quando a data for alterada
      onChange: function(selectedDates, dateStr, instance) {
          const selectedDate = selectedDates[0].toISOString().split("T")[0]; // Obter a data selecionada no formato YYYY-MM-DD
          const availableTimesForSelectedDate = availableDates.filter(date => date.startsWith(selectedDate));

          // Limpar o seletor de horários
          timeSelect.innerHTML = '';

          // Se houver horários disponíveis para a data selecionada, preencha o seletor
          if (availableTimesForSelectedDate.length > 0) {
              availableTimesForSelectedDate.forEach(time => {
                  const option = document.createElement('option');
                  const timeOnly = time.split("T")[1].substring(0, 5);  // Exibir apenas "HH:mm"
                  option.value = time;
                  option.text = timeOnly;  // Exibir apenas horas e minutos
                  timeSelect.appendChild(option);
              });

              // Exibir o seletor de horários e habilitar o botão de submissão
              timeSelect.disabled = false;
              submitButton.disabled = false;
              timeSlotContainer.style.display = 'block';
          } else {
              // Se não houver horários disponíveis, desabilitar o botão e ocultar o seletor de horários
              timeSelect.disabled = true;
              submitButton.disabled = true;
              timeSlotContainer.style.display = 'none';
          }
      }
  });
});
