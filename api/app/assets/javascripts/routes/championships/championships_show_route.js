App.ChampionshipsShowRoute = Ember.Route.extend({
  model: function (params) {
    return this.store.findRecord('championship', params.championship_id);
  }
});