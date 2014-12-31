TrelloClone.Collections.Boards = Backbone.Collection.extend({

  url: 'api/boards',

  model: TrelloClone.Models.Board,

  getOrFetch: function (id) {
    var maybeBoard = this.get(id);

    if (!(maybeBoard)) {
      maybeBoard = new TrelloClone.Models.Board({id: id});
      var collection = this;
      maybeBoard.fetch({
        success: function (model) {
          collection.add(model)
        }
      })
    } else {
      maybeBoard.fetch();
    }
    return maybeBoard;
  }
})
