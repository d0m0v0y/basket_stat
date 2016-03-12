App.Statistic = DS.Model.extend({
  player: DS.belongsTo('player', { async: true }),
  game: DS.belongsTo('game', { async: true }),
  team: DS.belongsTo('team', { async: true }),
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

  totalRebounds: Ember.computed(
    'offenciveRebounds',
    'deffenciveRebounds',
    function() {
      return this.get('offenciveRebounds') + this.get('deffenciveRebounds')
    }
  ),

  totalFreeThrows: Ember.computed(
    'freeThrowAttempts',
    'freeThrowMade',
    function() {
      return this.get('freeThrowAttempts') + this.get('freeThrowMade');
    }
  ),

  totalFieldGoals: Ember.computed(
    'fieldGoalAttempts',
    'fieldGoalMade',
    function() {
      return this.get('fieldGoalAttempts') + this.get('fieldGoalMade');
    }
  ),

  totalThreePoints: Ember.computed(
    'threePointAttempts',
    'threePointMade',
    function() {
      return this.get('threePointAttempts') + this.get('threePointMade');
    }
  ),
});