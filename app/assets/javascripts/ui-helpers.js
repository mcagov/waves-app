$(document).ready(function() {
  $('select.select2').select2({
    minimumResultsForSearch: Infinity
  });
});

$(document).on('keyup','.upcase.form-control', {} ,function(e){
  $(this).val($(this).val().toUpperCase());
})
