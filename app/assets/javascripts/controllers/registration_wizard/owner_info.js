$(document).ready(function () {
  if ($("#owner-info").length === 0) return;

  var ownerTitleField = $("#owner_title");
  var ownerTitleOtherField = new ShowHideContent(ownerTitleField);

  ownerTitleField.on("change", function (event) {
    if (event.target.value === "") {
      ownerTitleOtherField.showContent();
    } else {
      ownerTitleOtherField.hideContent();
    }
  });
});
