$(document).ready(function () {
  if ($("#vessel-info").length === 0) return;

  var vesselTypeIdField = $("#registration_vessels_attributes_0_vessel_type_id");
  var vesselTypeOtherField = new ShowHideContent(vesselTypeIdField);

  vesselTypeIdField.on("change", function (event) {
    if (event.target.value === "") {
      vesselTypeOtherField.showContent();
    } else {
      vesselTypeOtherField.hideContent();
    }
  });
});
