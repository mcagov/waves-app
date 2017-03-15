$(document).ready(function() {
  $('select.select2').select2({
    minimumResultsForSearch: Infinity,
    width: '100%'
  });

  $('select.select2.searchable').select2({
    minimumResultsForSearch: 10
  });

  $('#submission_vessel_propulsion_system').multiselect({
    buttonWidth: '100%'
  });

  $('[data-toggle="tooltip"]').tooltip()
});
$(document).on('keyup','.upcase.form-control', {} ,function(e){
  $(this).val($(this).val().toUpperCase());
})
