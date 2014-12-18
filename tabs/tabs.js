(function() {

  if (typeof TabsApp === "undefined") {
    window.TabsApp = {};
  }

  $.Tabs = function (el) {
    this.$el = $(el);
    // this.$contentTabs = $(this.$el.data("content-tabs"));
    this.$activeTab = $(".active");
    this.$el.on("click", "a", this.clickTab.bind(this));
  }

  $.Tabs.prototype.clickTab = function (event) {
    event.preventDefault();
    $target = $(event.currentTarget);
    this.$activeTab.removeClass("active");
    $target.addClass("active");
    $($target.attr("href")).addClass("active");
    this.$activeTab = $(".active");
  };

  $.fn.tabs = function () {
    return this.each(function () {
      new $.Tabs(this);
    });
  };


}());
