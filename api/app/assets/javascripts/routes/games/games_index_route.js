App.GamesIndexRoute = Ember.Route.extend({
  model: function () {
    return this.store.findAll('game');
  }
});
