

var TweetCompose = $.TweetCompose = function (el) {
  this.$el = $(el);
  this.$ul = $(this.$el.data("tweets-ul"));
  this.$el.on("submit", this.submit.bind(this));
  $(".tweet-compose textarea").on('input', this.charsLeftHandler.bind(this));
  $("a.add-mentioned-user").on('click', this.addMentionedUser);
  $(".tweet-compose").on('click', "a.remove-mentioned-user", this.removeMentionedUser);
}

TweetCompose.prototype.submit = function (event) {
  event.preventDefault();
  var contents = $(event.currentTarget).serializeArray();
  $.ajax({
    url: "/tweets",
    type: "POST",
    dataType: "json",
    data: contents,
    success: this.handleSuccess.bind(this)
  });
  this.$el.find(":input").prop("disabled", true);
}

TweetCompose.prototype.charsLeftHandler = function (event) {
  var $currentTarget = $(event.currentTarget);
  var $charsLeft = this.$el.find(".chars-left")
  console.log($currentTarget.val().length)
  $charsLeft.html(140 - $currentTarget.val().length);
};

TweetCompose.prototype.handleSuccess = function (data) {
  var $inputs = this.$el.find(":input");
  $inputs.prop("disabled", false);
  $inputs.not(".dontclear").val("");
  var $li = "<li>" + JSON.stringify(data) + "</li>";
  this.$ul.prepend($li);
};

TweetCompose.prototype.addMentionedUser = function () {
  var $scriptTag = $("script.mention-script");
  $("div.mentioned-users").append($scriptTag.html());
};

TweetCompose.prototype.removeMentionedUser = function (event) {
  $currentTarget = $(event.currentTarget);
  $currentTarget.parent().remove();
};

$.fn.tweetCompose = function () {
  return this.each(function () {
    new $.TweetCompose(this);
  });
}

$(function () {
  $("form.tweet-compose").tweetCompose();
});
