var ShowHideContent = function (control, excludeParent) {
  var targetId = $(control).attr("data-target");
  $(control).attr("aria-controls", targetId);

  var target = $("#" + targetId);
  if (excludeParent)
    this.target = target;
  else
    this.target = target.parent();

  this.target.addClass("panel panel-border-narrow");

  if (this.target.find("input").val())
    this.showContent();
  else
    this.hideContent();
};

ShowHideContent.prototype.showContent = function () {
  this.setHiddenState(false);
  this.target.removeClass("js-hidden");
  this.target.show();
};

ShowHideContent.prototype.hideContent = function () {
  this.target.find("input").val("");
  this.target.find("select").val("");
  this.target.hide();
  this.target.addClass("js-hidden");
  this.setHiddenState(true);
};

ShowHideContent.prototype.setHiddenState = function (state) {
  this.target.attr("aria-hidden", state.toString());
  this.target.attr("aria-expanded", (!state).toString());
};

