App.TeamsNewRoute = Ember.Route.extend({
  model: function () {
    return this.store.createRecord('team', {});
  },

  actions: {
    willTransition: function (transition) {
      if (transition.targetName !== 'teams.show') {
        return this.currentModel.deleteRecord();
      }
    }
  }
});