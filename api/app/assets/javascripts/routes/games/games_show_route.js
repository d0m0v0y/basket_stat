App.GamesShowRoute = Ember.Route.extend({
  model: function (params) {
    return this.store.find('game', params.game_id);
  },
  setupController: function (controller, model) {
    this._super(controller, model);
    var inGamePlayers = Ember.makeArray([
      Ember.Object.create({home: null, away: null}),
      Ember.Object.create({home: null, away: null}),
      Ember.Object.create({home: null, away: null}),
      Ember.Object.create({home: null, away: null}),
      Ember.Object.create({home: null, away: null})
    ]);
    controller.set('inGamePlayers', inGamePlayers);
    controller.set('points', { home: 0, away: 0 });
  }
});