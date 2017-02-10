$(document).ready(function () {
  $('a.edit_shareholding_in_place').editable({
    success:
      function(e, editable) {
        var submission_id = $('#submission-id').html();
        $.ajax({  url: '/submissions/' + submission_id + '/shareholding' });
      }
  });
});
