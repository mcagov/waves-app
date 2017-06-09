$(document).ready(function() {
  if ($("#reports").length === 0) return;

  $('.show_search_criteria').on('change', function() {
    var selection = this.value;
    if (selection.length = 0) return;

    $('#' + selection).removeClass('hidden');
    $('#' + selection + ' :input').removeAttr('disabled');
  });

  $('a.hide_search_criteria').on('click', function() {
    selection = $(this).closest('.form-group');

    selection.addClass('hidden');
    selection.find(':input').each(function() {
      $(this).attr('disabled', 'disabled');
    });
  });
});
