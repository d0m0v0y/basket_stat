App.PlayerNewController = Ember.Controller.extend({
  needs: ['player'],
  queryParams: ['team_id'],
  team_id: null,

  onSave: function (player) {
    return this.transitionToRoute('player.show', player);
  },

  onError: function (response) {
    Ember.Logger.error("Error on create new Player: ", response.error);
  },

  actions: {
    cancel: function () {
      this.model.deleteRecord();
      return this.transitionToRoute('teams.show', this.model.get('team'));
    },

    save: function () {
      return this.model.save().then(this.onSave.bind(this), this.onError.bind(this));
    }
  }
});