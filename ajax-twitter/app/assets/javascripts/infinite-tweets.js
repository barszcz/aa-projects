var InfiniteTweets = $.InfiniteTweets = function (el) {
  this.$el = $(el);
  this.maxCreatedAt = null;
  $("a.fetch-more").on("click", this.fetchTweets.bind(this))
};

$.InfiniteTweets.prototype.fetchTweets = function (event) {
  var content = {}
  if (this.maxCreatedAt != null) {
    content["max_created_at"] = this.maxCreatedAt;
  }
  $.ajax({
    url: "/feed",
    type: "GET",
    dataType: "json",
    data: content,
    success: this.fetchSuccess.bind(this)
  });
};

$.InfiniteTweets.prototype.fetchSuccess = function (data) {
  this.insertTweets(data);

};

$.InfiniteTweets.prototype.insertTweets = function (data) {
  data.forEach(function (tweet) {
    $("#feed").append("<li>" + JSON.stringify(tweet) + "</li>");
  })

  console.log(data.slice(-1)[0]);
  this.maxCreatedAt = data.slice(-1)[0].created_at;
};

$.fn.infiniteTweets = function () {
  return this.each(function () {
    new $.InfiniteTweets(this);
  });
}

$(function () {
  $("div.infinite-tweets").infiniteTweets();
});
