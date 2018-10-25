function initMortgageForm() {
  // validate the mortage form on submit()
  $('.mortgage-form').on('submit', function() {
    var scope = $(this).closest('.mortgage-form');
    var mortgage_type = $(scope).find('.mortgage-type').val();
    var mortgage_amount = $(scope).find('#mortgage_amount').val();

    var errors = 'Please amend the following errors:\n';
    var validations = true;

    // shares mortgaged
      if ((mortgage_amount == '') ||  (mortgage_amount == '0')) {
        errors = errors + ('Shares Mortgaged must be between 1 and 64\n');
        validations = false;
      }

    // addresses
    $(scope).find('.address-1').each(function() {
      if (($(this).val() == '') && (!$(this).hasClass('hidden'))) {
        errors = errors + 'Address 1 is required for Mortgagors and Mortgagees\n';
        validations = false;
        return false;
      }
    });

    // date executed
    if ($(scope).find('#mortgage_executed_at').val() == '') {
      if ( mortgage_type != 'Intent') {
        errors = errors + 'Date Executed cannot be blank';
        validations = false;
      }
    }

    if (validations == false) {
      alert(errors);
      return false;
    }
  });
}

$(document).ready(function() {
  initMortgageForm();
});
