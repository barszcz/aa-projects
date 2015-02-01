TrelloClone.Models.Board = Backbone.Model.extend({
    urlRoot: 'api/boards',

    lists: function () {
      this._lists = this._lists || new TrelloClone.Collections.Lists({}, {});

      return this._lists;
    },

    parse: function(response) {
      if (response.lists) {
        var newLists = response.lists;
        this.lists().set(newLists, {parse: true});
        delete response.newLists;
      }
      return response;
    }

})
