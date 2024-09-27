import flatpickr from "flatpickr";

document.addEventListener("DOMContentLoaded", () => {
  const datepicker = document.querySelector(".datepicker");

  if (datepicker) {
    const availableDates = JSON.parse(datepicker.dataset.availableDates || "[]"); // Horários disponíveis
    const bookedDates = JSON.parse(datepicker.dataset.bookedDates || "[]"); // Horários já reservados

    flatpickr(".datepicker", {
      enableTime: true,  // Habilitar a seleção de horários
      dateFormat: "Y-m-d H:i",  // Mostrar a data e hora no formato correto
      minDate: "today",
      altInput: true,
      altFormat: "F j, Y H:i",
      allowInput: false,  // Evitar que o paciente insira manualmente
      enable: availableDates.map(date => new Date(date)), // Permitir apenas horários disponíveis
      disable: bookedDates.map(date => new Date(date)), // Desabilitar horários já reservados
      onDayCreate: function(dObj, dStr, fp, dayElem) {
        const dateStr = dayElem.dateObj.toISOString().split("T")[0];

        // Adicionar classes CSS para destacar as cores
        if (bookedDates.includes(dateStr)) {
          dayElem.classList.add('booked-date');
        } else if (availableDates.includes(dateStr)) {
          dayElem.classList.add('available-date');
        }
      }
    });
  }
});
