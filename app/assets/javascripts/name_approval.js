$(document).ready(function() {
  $('#validate_name').on('click', function(e) {
    $('#name_approval form').submit();
    e.preventDefault();
  });

  $('#confirm_name_validation').on('click', function(e) {
    $('#name_approval form').submit();
    e.preventDefault();
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
