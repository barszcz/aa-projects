TrelloClone.Views.BoardsIndex = Backbone.View.extend({

  initialize: function () {
    this.listenTo(this.collection, "sync", this.render)
  },

  template: JST['boards/index'],

  render: function () {
    this.$el.html(this.template({boards: this.collection}));
    return this;
  }
})
