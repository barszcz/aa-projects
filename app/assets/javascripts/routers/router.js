JournalApp.Routers.Router = Backbone.Router.extend({

  initialize: function (options) {
    this.$rootEl = options.$rootEl;
  },

  routes: {
    '': 'index',
    'posts/new': 'new',
    'posts/:id': 'show',
  },

  index: function () {
    var indexView = new JournalApp.Views.PostsIndexView({
      collection: JournalApp.posts
    });
    this.$rootEl.html(indexView.render().$el);
  },

  show: function (id) {
    var post = JournalApp.posts.getOrFetch(id, {success: function() {
      var showView = new JournalApp.Views.PostsShowView({
        model: post
      })
      this.$rootEl.html(showView.render().$el)
    }.bind(this)})

    console.log(post);
  },

  new: function () {
    var post = new JournalApp.Models.Post();
    var postFormView = new JournalApp.Views.PostFormView({
      model: post,
      collection: JournalApp.posts
    });
    this.$rootEl.html(postFormView.render().$el);
  }
});
