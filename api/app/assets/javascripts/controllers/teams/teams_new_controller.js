App.TeamsNewController = Ember.ObjectController.extend({
  onSave: function (team) {
    return this.transitionToRoute('teams.show', team);
  },

  //failure: function (reason) {
  //  return Ember.Logger.error("Error on create new Team: ", reason);
  //},

  actions: {
    cancel: function () {
      this.model.deleteRecord();
      return this.transitionToRoute('teams');
    },

    save: function () {
      return this.model.save().then(this.onSave.bind(this));
    }
  }
});