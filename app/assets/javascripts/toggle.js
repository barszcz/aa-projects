var FollowToggle = $.FollowToggle = function (el, options) {
  this.$el = $(el);
  this.userId = this.$el.data("user-id") || options.userId;
  this.followState = this.$el.data("initial-follow-state") || options.followState;
  this.render(this.followState === "followed" ? "Unfollow!" : "Follow!");
  this.$el.on("click", this.handleClick.bind(this));
};

$.FollowToggle.prototype.render = function (buttonText) {
  this.$el.html(buttonText);
};

FollowToggle.prototype.handleClick = function (event) {
  event.preventDefault();

  var method, intermediateText, nextText, nextState;
  var toggle = this;

  if (this.followState === "followed") {
    method = "DELETE";
    intermediateText = "Unfollowing...";
    nextState = "unfollowed";
    nextText = "Follow!";
  } else {
    method = "POST";
    intermediateText = "Following...";
    nextState = "followed";
    nextText = "Unfollow!"
  }

  this.render(intermediateText);
  this.$el.prop("disabled", true);

  $.ajax({
    url: "/users/" + this.userId + "/follow",
    type: method,
    dataType: "json",
    success: function (data) {
      toggle.followState = nextState;
      toggle.render(nextText);
      toggle.$el.prop("disabled", false);
    }
  });



}

$.fn.followToggle = function (options) {
  return this.each(function () {
    new $.FollowToggle(this, options);
  });
}


$(function () {
  $("button.follow-toggle").followToggle();
});
