JournalApp.Views.PostsShowView = Backbone.View.extend({
  template: JST["postShow"],
  render: function() {
    var content = this.template({post: this.model});
    this.$el.html(content);
    return this;
  }
});
