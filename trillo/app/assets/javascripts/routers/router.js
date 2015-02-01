TrelloClone.Routers.Router = Backbone.Router.extend({

  initialize: function (options) {
    this.boards = options.boards;
    this.$el = options.$el;
  },

  routes: {
    "": "boardsIndex",
    "boards/new": "newBoard",
    "boards/:id": "boardShow",
  },

  swapView: function (newView) {
    this._currentView && this._currentView.remove();
    this._currentView = newView;
    this.$el.html(newView.render().$el);
  },

  boardsIndex: function () {
    var indexView = new TrelloClone.Views.BoardsIndex({collection: this.boards})
    this.boards.fetch();
    this.swapView(indexView);
  },

  newBoard: function () {
    var newView = new TrelloClone.Views.BoardNew({model: new TrelloClone.Models.Board()});
    this.swapView(newView);
  },

  boardShow: function (id) {
    var board = this.boards.getOrFetch(id);
    // board.lists().fetch();
    var showView = new TrelloClone.Views.BoardShow({model: board});
    this.swapView(showView);
  },


})
