JournalApp.Collections.Posts = Backbone.Collection.extend({
  url: "posts",
  model: JournalApp.Models.Post,

  getOrFetch: function (id, options) {
    var model;
    // debugger;

    if (this.get(id)) {
      model = this.get(id);
    }
    else
    {
      model = new this.model({
        id: id
      });
      this.add(model);
      model.fetch(options);
    }
    return model;
  }
})
