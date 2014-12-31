TrelloClone.Views.ListNew = Backbone.View.extend({

  initialize: function (options) {
    this.board = options.board;
    this.model.set({board_id: this.board.id})
  },

  events: {
    "submit #new-list": "submitForm"
  },


  template: JST['lists/new'],

  render: function () {
    this.$el.html(this.template());
    return this;
  },

  submitForm: function (event) {
    event.preventDefault();
    var model = this.model;
    this.model.set($('#new-list').serializeJSON());
    this.model.save({}, {
      success: function () {
        this.render();
      },
      failure: function () {
        this.render();
      }
    })
  }
})
