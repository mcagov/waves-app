// On the the submission details page we display a font-awesome star next
// to "similar" attributes in the "similar vessels" pane.
// With this script, we set the reciprocal attribute in the vessel pane.
$(document).ready(function() {

  // Editable attributes
  $('.editable-text').editable({ type: 'text' });
  $('.editable-select').editable({ type: 'select' });

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
});
