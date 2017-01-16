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

  function feedback_tonnage() {
    $('#approval_net-tonnage .form-control-feedback').html('NT');
    $('#approval_register-tonnage .form-control-feedback').html('RT');
  }

  $('#display_approval_register_tonnage').on('click', function() {
    $('#approval_register-tonnage').removeClass('hidden');
    $('#approval_net-tonnage').addClass('hidden');
  });

  $('#display_approval_net_tonnage').on('click', function() {
    $('#approval_net-tonnage').removeClass('hidden');
    $('#approval_register-tonnage').addClass('hidden');
  });

  // on load
  feedback_port_no();
});
