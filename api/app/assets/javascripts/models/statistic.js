App.Statistic = DS.Model.extend({
  game: DS.belongsTo('game', { async: false }),
  team: DS.belongsTo('team', { async: false }),
  players: DS.hasMany('player', { async: false }),
  points: DS.attr(),
  freeThrowAttempts: DS.attr(),
  freeThrowMade: DS.attr(),
  freeThrowPercent: DS.attr(),
  fieldGoalAttempts: DS.attr(),
  fieldGoalMade: DS.attr(),
  fieldGoalPercent: DS.attr(),
  threePointAttempts: DS.attr(),
  threePointMade: DS.attr(),
  threePointPercent: DS.attr(),
  assists: DS.attr(),
  blockshots: DS.attr(),
  offenciveRebounds: DS.attr(),
  deffenciveRebounds: DS.attr(),
  losses: DS.attr(),
  steels: DS.attr(),
  fouls: DS.attr(),
  foulsCommited: DS.attr(),
  efficiency: DS.attr(),
  lineup: DS.attr(),

  totalRebounds: Ember.computed(
    'offenciveRebounds',
    'deffenciveRebounds',
    function() {
      return this.get('offenciveRebounds') + this.get('deffenciveRebounds')
    }
  ),

  playerName: Ember.computed('players.@each.nameWithNumber', function(){
    return this.get('players.firstObject.nameWithNumber')
  })

});