App.GamesShowController = Ember.Controller.extend({
  gameStartedAt: null,
  timerValue: null,

  availableHomePlayers: function(){
    return this.get('model.homeTeam.players')
  }.property('model.homeTeam'),

  filteredHomePlayers: function(){
    var selected = this.get('inGamePlayers').getEach('home');
    var filtered = this.get('model.homeTeam.players');
    filtered.forEach(function (player) {
       if (selected.contains(player)){
         player.set('selected', true);
       } else {
         player.set('selected', false);
       }
    });
    return filtered;
  }.property('inGamePlayers.@each.home'),

  filteredAwayPlayers: function () {
    var selected = this.get('inGamePlayers').getEach('away');
    var filtered = this.get('model.awayTeam.players');
    filtered.forEach(function (player) {
      if (selected.contains(player)) {
        player.set('selected', true);
      } else {
        player.set('selected', false);
      }
    });
    return filtered;
  }.property('inGamePlayers.@each.away'),

  canNotStart: function(){
    var players = this.get('inGamePlayers');
    return players.any(function(item){
      return Ember.isEmpty(item.get('home')) || Ember.isEmpty(item.get('away'))
    });
  }.property('inGamePlayers.@each.home', 'inGamePlayers.@each.away'),

  homePlayerDidChange: function(){
    var players = this.get('inGamePlayers');
    players.forEach(function(obj){
      var player = obj.get('home');
      var oldPlayer = obj.get('oldHome');
      if ( player != oldPlayer) {
        if (Ember.isPresent(oldPlayer)) {
          Ember.Logger.info('OUT: ', oldPlayer.get('number'));
        }
        Ember.Logger.info('IN: ', player.get('number'));
        obj.set('oldHome', player);
      }
    });
  }.observes('inGamePlayers.@each.home'),

  awayPlayerDidChange: function () {
    var players = this.get('inGamePlayers');
    players.forEach(function (obj) {
      var player = obj.get('away');
      var oldPlayer = obj.get('oldAway');
      if (player != oldPlayer) {
        if (Ember.isPresent(oldPlayer)) {
          Ember.Logger.info('OUT: ', oldPlayer.get('number'));
        }
        Ember.Logger.info('IN: ', player.get('number'));
        obj.set('oldAway', player);
      }
    });
  }.observes('inGamePlayers.@each.away'),

  pointsEvent: function(player, eventType){
    var points = 0;
    switch(eventType){
      case 'ftm':
        points = 1;
        break;
      case 'fgm':
        points = 2;
        break;
      case 'fgm3':
        points = 3;
        break;
    }
    if (player.get('team.id') == this.get('model.homeTeam.id')){
      this.incrementProperty('points.home', points);
    } else {
      this.incrementProperty('points.away', points);
    }
  },

  actions: {
    gameStarted: function(){
      // starting game
      this.get('content.start');
    },

    finishGame: function(){
      // finishing game
      this.get('content.finish');
      return this.transitionToRoute('games.stats', this.get('model'))
    },

    gameEvent: function(player, type){
      //Ember.Logger.info('parent', player, type);
      var time = this.get('timerValue');
      if (Ember.isPresent(player) && Ember.isPresent(time)) {
        //Em.Logger.info('player: ', player, 'type: ', type);
        this.pointsEvent(player, type);
        var gameEvent = this.store.createRecord('gameEvent', {
          eventCode: type,
          eventTime: time,
          player: player,
          gameId: this.get('model.id')
        });
        gameEvent.save();
      }
    }
  }
});