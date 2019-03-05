$(document).ready(function() {
  $('#save-incomplete-application').on('shown.bs.modal', function() {
    if ($('form.edit_submission').length > 0) {
      $('form.edit_submission').submit();
      $('form.edit_submission :input').prop('disabled', true);
    }

    if ($('form.csr_form').length > 0) {
      $('form.csr_form').submit();
      $('form.csr_formn :input').prop('disabled', true);
    }

    $('#save-details-button').attr('disabled', 'disabled');
    $('#complete-task-button').attr('disabled', 'disabled');
  });

  $('#complete-task').on('shown.bs.modal', function() {
    if ($('form.edit_submission').length > 0) { $('form.edit_submission').submit(); }
    if ($('form.csr_form').length > 0) { $('form.csr_form').submit(); }
  });
});
