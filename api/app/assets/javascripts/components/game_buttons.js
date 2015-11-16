App.GameButtonsComponent = Ember.Component.extend({
  actions: {
      gameEvent: function (player, type) {
        //Ember.Logger.info('component', player, type);
        this.sendAction('action', player, type);
      }
  }
});