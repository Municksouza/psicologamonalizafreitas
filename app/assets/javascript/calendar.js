// Set up CSRF token for AJAX requests
$.ajaxSetup({
  headers: {
    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
  }
});

document.addEventListener('DOMContentLoaded', function() {
  var calendarEl = document.getElementById('calendar');

  if (calendarEl) {
    var calendar = new FullCalendar.Calendar(calendarEl, {
      plugins: ['dayGrid', 'interaction'],
      initialView: 'dayGridMonth',
      selectable: true,
      editable: true,
      events: '/appointments/index_json',  // Fetch appointments in JSON format

      // Select to create an appointment slot for psychologists
      select: function(selectionInfo) {
        if (currentRole === 'psychologist') {
          if (confirm('Do you want to create a new appointment slot for this time?')) {
            $.ajax({
              url: '/appointments',
              method: 'POST',
              data: {
                appointment: {
                  start_time: selectionInfo.startStr,
                  end_time: selectionInfo.endStr
                }
              },
              success: function(response) {
                alert('Appointment slot created successfully!');
                calendar.refetchEvents();  // Refresh the calendar
              },
              error: function(xhr) {
                alert('Error creating appointment slot: ' + xhr.responseText);
              }
            });
          }
        }
      },

      // Handle appointment booking and cancellation
      eventClick: function(info) {
        // Patients can book available appointments
        if (currentRole === 'patient' && info.event.extendedProps.status === 'available') {
          if (confirm('Do you want to book this appointment?')) {
            $.ajax({
              url: '/appointments/' + info.event.id + '/book',
              method: 'POST',
              success: function(response) {
                alert('Appointment booked successfully!');
                calendar.refetchEvents();  // Refresh the calendar
              },
              error: function(xhr) {
                alert('Error booking appointment: ' + xhr.responseText);
              }
            });
          }
        }

        // Psychologists can cancel appointments or delete slots
        if (currentRole === 'psychologist') {
          if (confirm('Do you want to edit or delete this appointment slot?')) {
            if (confirm('Delete this appointment slot?')) {
              $.ajax({
                url: '/appointments/' + info.event.id,
                method: 'DELETE',
                success: function(response) {
                  alert('Appointment slot deleted successfully!');
                  calendar.refetchEvents();  // Refresh the calendar
                },
                error: function(xhr) {
                  alert('Error deleting appointment slot: ' + xhr.responseText);
                }
              });
            }
          }
        }
      }
    });

    calendar.render();  // Render the calendar
  }
});
