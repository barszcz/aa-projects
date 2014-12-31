TrelloClone.Views.BoardNew = Backbone.View.extend({

  events: {
    "submit #new-board": "submitForm"
  },



  template: JST['boards/new'],

  render: function () {
    console.log(this.template());
    this.$el.html(this.template());
    return this;
  },

  submitForm: function (event) {
    event.preventDefault();
    this.model.save($('#new-board').serializeJSON(), {
      success: function () {
        Backbone.history.navigate('', {trigger: true});
      },

      failure: function () {
        this.render();
      }
    });
  }


})
