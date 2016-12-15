// On the the submission details page we display a font-awesome star next
// to "similar" attributes in the "similar vessels" pane.
// With this script, we set the reciprocal attribute in the vessel pane.
$(document).ready(function() {

  // WYSIWYG
  tinymce.init({
    selector: 'textarea.wysiwyg',
    menubar: false,
    toolbar: false,
    statusbar: false,
    height : 180
  });

  // Submission#edit: Promote an alternative vessel name
  $('.promote_alt_name').on('click', function() {
    var original_vessel_name = $('#submission_vessel_name').val();
    var new_vessel_name = $('#submission_vessel_' + this.id).val();

    console.log(original_vessel_name)
    console.log(new_vessel_name)

    $('#submission_vessel_name').val(new_vessel_name);
    $('#submission_vessel_' + this.id).val(original_vessel_name);

    return false;
  });

  // Submission#edit: Validate the owner name field (in modal)
  $('form#new_declaration').on('submit', function() {
    var owner_name_field = 'form#new_declaration #declaration_owner_name';

    if ($(owner_name_field).val().length == 0) {
      $(owner_name_field).addClass('field-error');
      return false;
    }
  });

  // Vessel#show: Similar vessel attribute icons
  if ($('#similar-vessels .similar-name').length) {
    $('#vessel-name .fa-star-o.hidden').removeClass('hidden');
  }
  if ($('#similar-vessels .similar-hin').length) {
    $('#vessel-hin .fa-star-o.hidden').removeClass('hidden');
  }
  if ($('#similar-vessels .similar-mmsi_number').length) {
    $('#vessel-mmsi_number .fa-star-o.hidden').removeClass('hidden');
  }
  if ($('#similar-vessels .similar-radio_call_sign').length) {
    $('#vessel-radio_call_sign .fa-star-o.hidden').removeClass('hidden');
  }

  // General: set the datepicker time format
  $('.datetimepicker').datetimepicker({
    format: 'DD/MM/YYYY, h:mm:ss a'
  });


  // Submissions#new: toggle Official No / Vessel Name field
  if ($("form#new_submission").length) {
    set_task_type_depenencies();
  }

  $('form #submission_task').on('change', function(){
    set_task_type_depenencies();
  })

  function set_task_type_depenencies() {
    var current_task_type = $('form #submission_task').val();

    if (current_task_type == 'new_registration') {
      $('#submission_vessel_name').removeClass('hidden');
      $('#submission_vessel_reg_no').addClass('hidden');
    }
    else{
      $('#submission_vessel_name').addClass('hidden');
      $('#submission_vessel_reg_no').removeClass('hidden');
    }

  }

});
