(function() {

  if (typeof TabsApp === "undefined") {
    window.TabsApp = {};
  }

  $.Tabs = function (el) {

  }

  $.fn.tabs = function () {
    return this.each(function () {
      new $.Tabs(this);
    });
  };

  
}());
