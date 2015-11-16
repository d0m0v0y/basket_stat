App.TeamsEditController = Ember.ObjectController.extend({
  onSave: function (team) {
    return this.transitionToRoute('teams.show', team);
  },

  //failure: function (reason) {
  //  return Ember.Logger.error("Error on edit new Team: ", reason);
  //},

  actions: {
    cancel: function () {
      this.model.rollback();
      return this.transitionToRoute('teams');
    },

    save: function () {
      return this.model.save().then(this.onSave.bind(this));
    }
  }
});