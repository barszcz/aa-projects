TrelloClone.Views.BoardNew = Backbone.View.extend({


  events: {
    "submit #new-board": "submitForm"
  },



  template: JST['boards/new'],

  render: function () {
    this.$el.html(this.template());
    return this;
  },

  submitForm: function (event) {
    event.preventDefault();
    var model = this.model;
    this.model.save($('#new-board').serializeJSON(), {
      success: function () {
        Backbone.history.navigate('boards/' + model.id, {trigger: true});
      },

      failure: function () {
        this.render();
      }
    });
  }


})
