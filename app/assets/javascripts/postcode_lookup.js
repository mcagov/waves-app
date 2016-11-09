$(document).ready(function () {
  if ($("#postcode-lookup").length === 0) return;

  $('#lookup_field').setupPostcodeLookup(
    {
    api_key: $("#postcode_lookup_api_key")[0].innerHTML,
    output_fields: {
      line_1: '.address_1',
      line_2: '.address_2',
      line_3: '.address_3',
      post_town: '.town',
      postcode: '.postcode'
    },
    input: '#postcode_lookup_field',
    button: '#postcode_lookup_button',
    dropdown_class: "select form-control",
    onAddressSelected: function (error, address) {
      $('.address_1')[0].value = $('.address_1')[0].value.toLocaleUpperCase();
      $('.address_2')[0].value = $('.address_2')[0].value.toLocaleUpperCase();
      $('.address_3')[0].value = $('.address_3')[0].value.toLocaleUpperCase();
    }
  });
});
