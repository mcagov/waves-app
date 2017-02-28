$(document).ready(function() {
  $('#validate_name').on('click', function() {
    $('form#new_submission_name_approval').submit();
  });

  $('#confirm_name_validation').on('click', function() {
    $('form#new_submission_name_approval').submit();
  });

  function feedback_port_no() {
    var port_code = $('#submission_name_approval_port_code').val();
    $('.approval_port-no .form-control-feedback').html(port_code)
  }

  $('#submission_name_approval_port_code').on('change', function(){
    feedback_port_no();
  });

  // on load
  feedback_port_no();
});
