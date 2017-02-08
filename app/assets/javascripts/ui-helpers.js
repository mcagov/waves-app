$(document).ready(function() {
  $('select.select2').select2({
    minimumResultsForSearch: Infinity
  });
});
$(document).ready(function() {
  $('select.select2.searchable').select2({
    minimumResultsForSearch: 10
  });
});
$(document).on('keyup','.upcase.form-control', {} ,function(e){
  $(this).val($(this).val().toUpperCase());
})
$(document).ready(function() {
  $('a.edit_in_place').editable();
});
