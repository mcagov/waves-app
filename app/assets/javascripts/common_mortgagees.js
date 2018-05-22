$(document).ready(function () {

  $(document).on('change', '#common_mortgagees', function() {
    var scope = $(this).closest('.nested-fields');

    var fields = $(this).val().split(";");

    $(scope).find('.name')[0].value       = fields[0];
    $(scope).find('.address-1')[0].value  = fields[1];
    $(scope).find('.address-2')[0].value  = fields[2];
    $(scope).find('.address-3')[0].value  = fields[3];
    $(scope).find('.town')[0].value       = fields[4];
    $(scope).find('.postcode')[0].value   = fields[6];
    $(scope).find('.country').val(fields[5]);
  });
});
