$(document).ready(function () {
  if ($("#delivery-address").length === 0) return;

  var deliveryAddressToggle = $(
    "[name='delivery_address[delivery_address_toggle]']"
  );
  var deliveryAddress = new ShowHideContent(deliveryAddressToggle, true);

  deliveryAddressToggle.on("change", function (event) {
    if (event.target.value === "true") {
      deliveryAddress.showContent();
    } else {
      deliveryAddress.hideContent();
    }
  });
});

