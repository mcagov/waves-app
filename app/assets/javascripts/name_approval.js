$(document).ready(function() {
  $('#submission_name_approval_registration_type').on('change', function() {
    var registration_type = $(this).val();
    var part = $('#submission_name_approval_part').val();

    if (part != 'part_4'){ return }

    if (registration_type == 'fishing') {
      $('.port_no_fields').removeClass('hidden');
    }
    else
    {
      $('.port_no_fields').addClass('hidden');
    }
  });

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
    $('#submission_name_approval_port_no').val('');
  });

  // on load
  feedback_port_no();
});
