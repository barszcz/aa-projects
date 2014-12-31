TrelloClone.Routers.Router = Backbone.Router.extend({

  initialize: function (options) {
    this.boards = options.boards;
    this.$el = options.$el;
  },

  routes: {
    "": "boardsIndex",
    "boards/new": "newBoard"
  },

  boardsIndex: function () {
    var indexView = new TrelloClone.Views.BoardsIndex({collection: this.boards})
    this.boards.fetch();
    this.$el.html(indexView.render().$el);
  },

  newBoard: function () {
    var newView = new TrelloClone.Views.BoardNew({model: new TrelloClone.Models.Board()});
    this.$el.html(newView.render().$el);
  },
})
