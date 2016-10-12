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

  // Editable attributes
  // Note that we add a class .upcase after *some* of the attributes
  // have been updated. This is to mimic the upcase action that is
  // done in the controller
  $('.editable-select').editable({ type: 'select' });
  $('.editable-email').editable({ type: 'text' });

  $('.editable-text').editable({
    type: 'text',
    success:  function(response, newValue) {
      $(this).addClass('upcase');
    }
  });

  $('.editable-delivery-address').editable({
    type: 'text',
    success:  function(response, newValue) {
      $("a#inline_delivery_address").text(response.inline_name_and_address);
    }
  });

  $('.editable-delivery-country').editable({
    type: 'select',
    success:  function(response, newValue) {
      $("a#inline_delivery_address").text(response.inline_name_and_address);
    }
  });

  $('.editable-owner-address').editable({
    type: 'text',
    success:  function(response, newValue) {
      var target = response.target_id;
      $("a#inline_owner_address_" + target).text(response.inline_address);
    }
  });

  $('.editable-owner-country').editable({
    type: 'select',
    success:  function(response, newValue) {
      var target = response.target_id;
      $("a#inline_owner_address_" + target).text(response.inline_address);
    }
  });

  // Similar vessel attribute icons
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

  $('.datetimepicker').datetimepicker({
    format: 'DD/MM/YYYY, h:mm:ss a'
  });
});
