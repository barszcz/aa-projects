TrelloClone.Views.BoardShow = Backbone.CompositeView.extend({

  template: JST['boards/show'],

  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
    this.listenTo(this.model, "destroy", function () {
      Backbone.history.navigate('/', {trigger: true});
    });
    this.addSubview(".new-list-form", new TrelloClone.Views.ListNew({
      model: new TrelloClone.Models.List,
      board: this.model
    }));
  },

  events: {
    "click button.delete-button": "deleteBoard"
  },

  render: function () {
    this.$el.html(this.template({board: this.model}));
    this.attachSubviews();
    return this;
  },

  deleteBoard: function () {
    this.model.destroy();
  }
})
