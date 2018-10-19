$(document).ready(function() {
  // Intent mortgage defauls to no shares
  // Other mortgages default to 0 shares
  $('.mortgage-type').on('change', function() {
    var scope = $(this).closest('.mortgage-form');

    if ($(this).val() == 'Intent') {
      $('#mortgage_amount').val(0);
    }
    else {
      $(scope).find('#mortgage_amount').val("0");
    }
  })

  // validate the mortage form on submit()
  $('.mortgage-form').on('submit', function() {
    var scope = $(this).closest('.mortgage-form');
    var mortgage_type = $(scope).find('.mortgage-type').val();
    var mortgage_amount = $(scope).find('#mortgage_amount').val();

    // shares mortgaged
    if ( mortgage_type == 'Intent') {
      if (mortgage_amount != '') {
        alert('Shares Mortgaged must be blank for a mortgage type: Intent');
        return false;
      }
    }
    else {
      if ((mortgage_amount == '') ||  (mortgage_amount == '0')) {
        alert('Shares Mortgaged must be 1 or more for mortgage type: ' + mortgage_type);
        return false;
      }
    }
  })
});
