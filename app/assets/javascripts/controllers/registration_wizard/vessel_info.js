$(document).ready(function () {
  if ($("#vessel-info").length === 0) return;

  var formIdPrefix = "#registration_vessel_attributes_";

  var vesselTypeIdField = $(formIdPrefix + "vessel_type_id");
  var vesselTypeOtherField = new ShowHideContent(vesselTypeIdField);

  vesselTypeIdField.on("change", function (event) {
    if (event.target.value === "") {
      vesselTypeOtherField.showContent();
    } else {
      vesselTypeOtherField.hideContent();
    }
  });

  new LimitNumberField("#length_in_centimeters_m", 2);
  new LimitNumberField("#length_in_centimeters_cm", 2);
  new LimitNumberField(formIdPrefix + "mmsi_number", 9);
});
