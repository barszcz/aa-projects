TrelloClone.Collections.Lists = Backbone.Collection.extend({

  model: TrelloClone.Models.List,

  url: 'api/lists',

  comparator: 'ord',

  getOrFetch: function (id) {
    var maybeList = this.get(id);

    if (!(maybeList)) {
      maybeList = new TrelloClone.Models.List({id: id});
      var collection = this;
      maybeList.fetch({
        success: function (model) {
          collection.add(model)
        }
      })
    } else {
      maybeList.fetch();
    }
    return maybeList;
  }

})
