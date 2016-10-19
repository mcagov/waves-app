$(document).ready(function() {
  $('select.select2').select2({
    minimumResultsForSearch: Infinity
  });

  // Upper case input fields
  $(function() {
    $('.upcase.form-control').focusout(function() {
        this.value = this.value.toLocaleUpperCase();
    });
  });
});
