$(document).ready(function() {
  $('#login-button').on('click', function(event) {
    event.preventDefault(); // Prevent default form submission

    $.ajax({
      url: '/patients/sign_in',
      type: 'GET', // or POST depending on what you're trying to do
      dataType: 'html', // Specify that the response format is HTML
      success: function(response) {
        // Handle the response here
        $('#login-form-container').html(response); // Replace with the response content
      },
      error: function(xhr, status, error) {
        console.error('An error occurred: ' + error);
      }
    });
  });
});
