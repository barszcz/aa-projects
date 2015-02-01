Pokedex.Router = Backbone.Router.extend({
  routes: {
    '': 'pokemonIndex',
    'pokemon/:id': 'pokemonDetail',
    'pokemon/:pkmnId/toys/:toyId': 'toyDetail'
  },

  pokemonDetail: function (id, callback) {
    if (this._pokemonIndex) {
      var poke = this._pokemonIndex.collection.get(id);
      this._pokemonDetail = new Pokedex.Views.PokemonDetail({model: poke});
      $('#pokedex .pokemon-detail').html(this._pokemonDetail.render().$el);
      callback && callback();
    } else {
      this.pokemonIndex(function() {this.pokemonDetail(id, callback)}.bind(this));
    }
  },

  toyDetail: function (pkmnId, toyId) {
    if (this._pokemonDetail) {
      var toy = this._pokemonDetail.model.toys().get(toyId);
      var toyDetail = new Pokedex.Views.ToyDetail({model: toy});
      $('#pokedex .toy-detail').html(toyDetail.render().$el);
    } else {
      this.pokemonDetail(pkmnId, function() {this.toyDetail(pkmnId, toyId)}.bind(this));
    }
  },

  pokemonIndex: function (callback) {
    this._pokemonIndex = new Pokedex.Views.PokemonIndex();
    var that = this;
    this.pokemonForm();
    this._pokemonIndex.refreshPokemon(function() {
      $("#pokedex .pokemon-list").html(that._pokemonIndex.$el);
      callback && callback();
    });
  },


  pokemonForm: function () {
    var pModel = new Pokedex.Models.Pokemon();
    var pokemonForm = new Pokedex.Views.PokemonForm ({
      model: pModel,
      collection: this._pokemonIndex.collection
    });
    $('#pokedex .pokemon-form').html(pokemonForm.render().$el);

  }
});


$(function () {
  new Pokedex.Router();
  Backbone.history.start();
});
