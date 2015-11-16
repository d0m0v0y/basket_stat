App.PlayerNewRoute = Ember.Route.extend({
  model: function (params) {
    player = this.store.createRecord('player', {});
    this.store.find('team', params.team_id).then(function(team){
      team.get('players').addObject(player);
    });
    return player;
  },

  actions: {
    willTransition: function (transition) {
      if (transition.targetName !== 'player.show') {
        return this.currentModel.deleteRecord();
      }
    }
  }
});