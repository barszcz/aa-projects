Pokedex.Views = {}

Pokedex.Views.PokemonIndex = Backbone.View.extend({
  events: {
    "click li": "selectPokemonFromList"
  },

  initialize: function () {
    this.collection = new Pokedex.Collections.Pokemon();
  },

  addPokemonToList: function (pokemon) {
    this.$el.append(JST['pokemonListItem']({pokemon: pokemon}));
  },

  refreshPokemon: function (callback) {
    var that = this;
    this.collection.fetch(
    {success: function () {
        that.render();
        callback && callback();
      }
    })
  },

  render: function () {
    this.$el.empty();
    this.collection.each(this.addPokemonToList.bind(this));
    return this;
  },

  selectPokemonFromList: function (event) {
    event.preventDefault();
    var $target = $(event.currentTarget);
    var pokeId = $target.data("id");
    Backbone.history.navigate("pokemon/" + pokeId, { trigger: true });
    // var pokeDetail = new Pokedex.Views.PokemonDetail(poke);
    // $('#pokedex .pokemon-detail').empty().html(pokeDetail.$el);
    // pokeDetail.refreshPokemon();
  }
});

Pokedex.Views.PokemonDetail = Backbone.View.extend({
  events: {
    "click .toys li": "selectToyFromList"
  },

  initialize: function (options) {
    // this.model = options.model;
    this.refreshPokemon();
    this.toys = this.model.toys();
    // debugger;
  },

  refreshPokemon: function (options) {
    var that = this;
    this.model.fetch({
      success: function () {
        that.render();
      }
    })
  },

  render: function () {
    this.$el.html(JST['pokemonDetail']({pokemon: this.model}))
    this.toys.each(function (toy) {
      this.$el.find("ul.toys").append(JST['toyListItem']({toy: toy}));
    }.bind(this));

    return this;
  },

  selectToyFromList: function (event) {
    event.preventDefault();
    var $target = $(event.currentTarget);
    var toy = this.toys.get($target.data("id"));
    var toyId = toy.get('id');
    var pkmnId = toy.get('pokemon_id');
    Backbone.history.navigate("pokemon/" + pkmnId + "/toys/" + toyId, {trigger: true});
    // var toyDetail = new Pokedex.Views.ToyDetail({model: toy});
    // var poke = this.model;
    // $('#pokedex .toy-detail').html(toyDetail.render().$el);
  }
});

Pokedex.Views.ToyDetail = Backbone.View.extend({
  initialize: function (options) {
    // this.model = options.model;
  },

  render: function () {
    // var pokemen = new Pokedex.Collections.Pokemon();
    // pokemen.fetch({success: function () {
    //
    // }})
    this.$el.html(JST['toyDetail']({toy: this.model, pokemen: [] }));
    return this;
  }
});

$(function () {
  var pokemonIndex = new Pokedex.Views.PokemonIndex();
  pokemonIndex.refreshPokemon();
  $("#pokedex .pokemon-list").html(pokemonIndex.$el);
});
