$(document).ready(function() {
  $('#save-incomplete-application').on('shown.bs.modal', function() {
    $('form.edit_submission').submit();
  });
});
