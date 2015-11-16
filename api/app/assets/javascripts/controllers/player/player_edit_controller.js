App.PlayerEditController = Ember.Controller.extend({
  needs: ['player'],
  onSave: function (player) {
    return this.transitionToRoute('player.show', player);
  },

  actions: {
    cancel: function () {
      this.model.rollback();
      return this.transitionToRoute('teams.show', this.model.get('team'));
    },

    save: function () {
      return this.model.save().then(this.onSave.bind(this));
    }
  }
});