App.StatisticSummary = Ember.Object.extend({
  data: null,
  team: null,
  chartKeys: null,
  name: null,

  stats: Ember.computed.filter('data.statistics', function(row){
    return Em.isEqual(row.get('team.id'), this.get('team.id'));
  }),

  freeThrowMade: Ember.computed('stats.@each.freeThrowMade', function(){
    return this.get('stats').reduce(function(acc, value) {
      return acc + value.get('freeThrowMade');
    }, 0)
  }),

  freeThrowPercent: Ember.computed('freeThrowMade', 'stats.@each.freeThrowAttempts', function(){
    var totals = this.get('stats.@each.freeThrowAttempts').reduce(function(acc, value) {
      return acc + value;
    }, 0);
    return Math.round(this.get('freeThrowMade') / totals * 100);
  }),

  fieldGoalMade: Ember.computed('stats.@each.fieldGoalMade', function(){
    return this.get('stats').reduce(function(acc, value) {
      return acc + value.get('fieldGoalMade') * 2;
    }, 0)
  }),

  fieldGoalPercent: Ember.computed('fieldGoalMade', 'stats.@each.fieldGoalAttempts', function(){
    var totals = this.get('stats.@each.fieldGoalAttempts').reduce(function(acc, value) {
      return acc + value;
    }, 0);
    return Math.round((this.get('fieldGoalMade') / 2)/ totals * 100);
  }),

  threePointMade: Ember.computed('stats.@each.threePointMade', function(){
    return this.get('stats').reduce(function(acc, value) {
      return acc + value.get('threePointMade') * 3;
    }, 0)
  }),

  threePointPercent: Ember.computed('threePointMade', 'stats.@each.threePointAttempts', function(){
    var totals = this.get('stats.@each.threePointAttempts').reduce(function(acc, value) {
      return acc + value;
    }, 0);
    return Math.round((this.get('threePointMade') / 3)/ totals * 100);
  }),

  totalRebounds: Ember.computed('stats.@each.totalRebounds', function(){
    return this.get('stats').reduce(function(acc, value) {
      return acc + value.get('totalRebounds');
    }, 0)
  }),

  fouls: Ember.computed('stats.@each.fouls', function(){
    return this.get('stats').reduce(function(acc, value) {
      return acc + value.get('fouls');
    }, 0)
  }),

  efficiency: Ember.computed('stats.@each.efficiency', function(){
    return this.get('stats').reduce(function(acc, value) {
      return acc + value.get('efficiency');
    }, 0)
  }),

  chartArray: Ember.computed('stats', function(){
    var self = this;
    return this.get('chartKeys').map(function(key){
      return self.get(key);
    })
  }),

  chartData: Ember.computed('chartArray','team.name', function(){
    return {
      name: this.get('name'),
      data: this.get('chartArray')
    }
  })

});
