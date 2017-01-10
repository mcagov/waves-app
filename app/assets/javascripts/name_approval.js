$(document).ready(function() {
  $('#validate_name').on('click', function() {
    $('form#new_submission_name_approval').submit();
  });

  $('#confirm_name_validation').on('click', function() {
    $('form#new_submission_name_approval').submit();
  });
});
