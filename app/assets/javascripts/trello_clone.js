window.TrelloClone = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    var boards = new TrelloClone.Collections.Boards();
    new TrelloClone.Routers.Router({$el: $("#main"), boards: boards});
    Backbone.history.start();

  }
};

// $(function () {
//   window.TrelloClone.initialize();
// });
