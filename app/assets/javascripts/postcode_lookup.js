$(document).ready(function () {

  // Postcode lookup for primary address fields
  $(document).on('click', '.postcode-lookup-button', function(e) {
    e.preventDefault();
  });

  $(document).on('focus', '.postcode-lookup-field', function() {
    var scope = this.closest('.postcode-lookup');

    if ($(scope).find('.postcode-results-field')[0].innerHTML != '') {
      return false;
    }

    var address_1 = $(scope).find('.address-1')[0];
    var address_2 = $(scope).find('.address-2')[0];
    var address_3 = $(scope).find('.address-3')[0];
    var town = $(scope).find('.town')[0];
    var postcode = $(scope).find('.postcode')[0];
    var postcode_results_field = $(scope).find('.postcode-results-field');

    postcode_results_field.setupPostcodeLookup(
      {
      api_key: $(".postcode-lookup-api-key")[0].innerHTML,
      output_fields: {
        line_1: address_1,
        line_2: address_2,
        line_3: address_3,
        post_town: town,
        postcode: postcode
      },
      input: $(scope).find('.postcode-lookup-field'),
      button: $(scope).find('.postcode-lookup-button'),
      dropdown_class: "select form-control",

      onAddressSelected: function (error, address) {
        $(address_1)[0].value = $(address_1)[0].value.toLocaleUpperCase();
        $(address_2)[0].value = $(address_2)[0].value.toLocaleUpperCase();
        $(address_3)[0].value = $(address_3)[0].value.toLocaleUpperCase();
      }
    });
  });

  // Postcode lookup for alt_address fields
  $(document).on('click', '.alt_postcode-lookup-button', function(e) {
    e.preventDefault();
  });

  $(document).on('focus', '.alt_postcode-lookup-field', function() {
    var scope = this.closest('.postcode-lookup');

    if ($(scope).find('.alt_postcode-results-field')[0].innerHTML != '') {
      return false;
    }

    var address_1 = $(scope).find('.alt_address-1')[0];
    var address_2 = $(scope).find('.alt_address-2')[0];
    var address_3 = $(scope).find('.alt_address-3')[0];
    var town = $(scope).find('.alt_town')[0];
    var postcode = $(scope).find('.alt_postcode')[0];
    var postcode_results_field = $(scope).find('.alt_postcode-results-field');

    postcode_results_field.setupPostcodeLookup(
      {
      api_key: $(".alt_postcode-lookup-api-key")[0].innerHTML,
      output_fields: {
        line_1: address_1,
        line_2: address_2,
        line_3: address_3,
        post_town: town,
        postcode: postcode
      },
      input: $(scope).find('.alt_postcode-lookup-field'),
      button: $(scope).find('.alt_postcode-lookup-button'),
      dropdown_class: "select form-control",

      onAddressSelected: function (error, address) {
        $(address_1)[0].value = $(address_1)[0].value.toLocaleUpperCase();
        $(address_2)[0].value = $(address_2)[0].value.toLocaleUpperCase();
        $(address_3)[0].value = $(address_3)[0].value.toLocaleUpperCase();
      }
    });
  });
});
