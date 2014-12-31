TrelloClone.Models.List = Backbone.Model.extend({

  urlRoot: '/api/lists',

  toJSON: function () {
    return {list: _.clone(this.attributes)};
  }

})
