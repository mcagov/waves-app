$(document).ready(function() {
  if ($("#reports").length === 0) return;

  $('.show_search_criteria').on('change', function() {
    var selection = this.value;
    if (selection.length = 0) return;

    $('#' + selection).removeClass('hidden');
    $('#' + selection + ' :input').removeAttr('disabled');
  });
});
