$(document).ready(function() {
  $('#save-incomplete-application').on('shown.bs.modal', function() {
    if ($('form.edit_submission').length > 0) { $('form.edit_submission').submit(); }
    if ($('form.csr_form').length > 0) { $('form.csr_form').submit(); }
  });
});
