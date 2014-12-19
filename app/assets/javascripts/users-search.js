var UsersSearch = $.UsersSearch = function (el) {
  this.$el = $(el);
  this.$input = this.$el.find("#username");
  this.$ul = this.$el.find(".users");
  this.$input.on("input", this.handleInput.bind(this));
}

UsersSearch.prototype.handleInput = function (event) {
  $.ajax({
    url: "/users/search",
    type: "GET",
    dataType: "json",
    data: { query: this.$input.val() },
    success: this.renderResults.bind(this)
  });
};

UsersSearch.prototype.renderResults = function (users) {
  this.$ul.empty();
  var $ul = this.$ul

  var userTempCode = $("#user-template").html();

  users.forEach(function (user) {
    var templateFn = _.template(userTempCode);
    var $newUser = $(templateFn({user: user}));
    $ul.append($newUser);
    $newUser.find('.follow-toggle').followToggle({userId: user.id, followState: user.follow_state});
  });
};

$.fn.usersSearch = function () {
  return this.each(function () {
    new $.UsersSearch(this);
  });
}


$(function () {
  $("section.users-search").usersSearch();
});
