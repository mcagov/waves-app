$(document).ready(function() {
  $('select.select2').select2({
    minimumResultsForSearch: Infinity,
    width: '100%', placeholder: "", allowClear: true
  });

  $('select.select2.searchable').select2({
    minimumResultsForSearch: 10, placeholder: "", allowClear: true
  });

  $('#submission_vessel_propulsion_system').select2({
    tags: true
  });

  $('[data-toggle="tooltip"]').tooltip()

  $('.datetimepicker').datetimepicker({
    format: 'DD/MM/YYYY, h:mm:ss a'
  });

  $('.datepicker').datepicker({
    format: 'dd/mm/yyyy',
    autoclose: true
  });
});

$(document).on('blur','.upcase.form-control', {} ,function(e){
  $(this).val($(this).val().toUpperCase());
})

 $(document).on('change', '.select_owner_mortgagor', function() {
    var fields = $(this).closest('.nested-fields');
    if ($(this).val().length > 0) {
      $(fields).find('.name-field').addClass('hidden');
      $(fields).find('.address-fields').addClass('hidden');
    }
    else
    {
      $(fields).find('.name-field').removeClass('hidden');
      $(fields).find('.address-fields').removeClass('hidden');
    }
  });
