var ShowHideContent = function (control) {
  var targetId = $(control).attr("data-target");
  $(control).attr("aria-controls", targetId);

  this.target = $("#" + targetId).parent();
  this.target.addClass("panel panel-border-narrow");

  this.hideContent();
};

ShowHideContent.prototype.showContent = function () {
  this.setHiddenState(false);
  this.target.removeClass("js-hidden");
  this.target.show();
};

ShowHideContent.prototype.hideContent = function () {
  this.target.hide();
  this.target.addClass("js-hidden");
  this.setHiddenState(true);
};

ShowHideContent.prototype.setHiddenState = function (state) {
  this.target.attr("aria-hidden", state.toString());
  this.target.attr("aria-expanded", (!state).toString());
};
