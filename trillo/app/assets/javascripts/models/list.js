TrelloClone.Models.List = Backbone.Model.extend({

  urlRoot: '/api/lists',

  toJSON: function () {
    return {list: _.clone(this.attributes)};
  },

  cards: function () {
    this._cards = this._cards || new TrelloClone.Collections.Cards({}, {});
    return this._cards
  },

  parse: function(response) {
    if (response.cards) {
      var newCards = response.cards;
      this.cards().set(newCards, {parse: true});
      delete response.newCards;
    }
    return response;
  }

})
