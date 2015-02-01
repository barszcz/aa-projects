Pokedex.Views = (Pokedex.Views || {});

Pokedex.Views.PokemonForm = Backbone.View.extend({
  events: {
    "submit": "savePokemon"
  },

  render: function () {
    this.$el.html(JST['pokemonForm']({}))
    return this;
  },

  savePokemon: function (event) {
    event.preventDefault();
    var $target = $(event.target);
    var ser = $target.serializeJSON().pokemon;
    console.log(ser);
    this.model.save(ser, {
      success: function () {
        this.collection.add(this.model);
        Backbone.history.navigate("pokemon/" + this.model.id, { trigger: true });
      }.bind(this)
    });
  }
});
