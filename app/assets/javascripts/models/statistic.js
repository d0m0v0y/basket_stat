App.Statistic = DS.Model.extend({
  player: DS.belongsTo('player'),
  game: DS.belongsTo('game'),
  team: DS.belongsTo('team'),
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

});