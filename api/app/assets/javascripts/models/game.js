App.Game = DS.Model.extend({
  homeTeam: DS.belongsTo('team', { async: true }),
  awayTeam: DS.belongsTo('team', { async: true }),

  date: DS.attr('date'),
  startedAt: DS.attr('date'),
  finishedAt: DS.attr('date'),
  homeTeamScores: DS.attr(),
  awayTeamScores: DS.attr(),

  statistics: DS.hasMany('statistic'),

  isFinished: function(){
    return Ember.isPresent(this.get('finishedAt'));
  }.property('finishedAt'),

  isStarted: function () {
    return Ember.isPresent(this.get('startedAt'));
  }.property('startedAt'),

  customAction: function (action) {
    var adapter = this.store.adapterFor('application');
    var url = adapter.buildURL('games', this.get('id')) + '/'+ action;
    var self = this;
    Ember.$.post(url).then(function (result) {
      self.store.pushPayload('game', result);
    });
  },

  start: function () {
    this.customAction('start');
  }.property('id'),

  finish: function () {
    this.customAction('finish');
  }.property('id'),

  // Stats section
  homeTeamStatsUnordered: Ember.computed.filter('statistics', function(row){
    return row.get('team.id') == this.get('homeTeam.id')
  }),
  awayTeamStatsUnordered: Ember.computed.filter('statistics', function(row){
    return row.get('team.id') == this.get('awayTeam.id')
  }),

  lineupOrder: ['lineup:desc'],
  homeTeamStats: Ember.computed.sort('homeTeamStatsUnordered', 'lineupOrder'),
  awayTeamStats: Ember.computed.sort('awayTeamStatsUnordered', 'lineupOrder'),

  //homeTeamLineupStats: Ember.computed.filterBy('homeTeamStats', 'lineup', true),
  //homeTeamBenchStats: Ember.computed.filterBy('homeTeamStats', 'lineup', false),
  //
  //awayTeamLineupStats: Ember.computed.filterBy('awayTeamStats', 'lineup', true),
  //awayTeamBenchStats: Ember.computed.filterBy('awayTeamStats', 'lineup', false),

  //homeLineupFT: Ember.computed('homeTeamLineupStats', function(){
  //  //debugger;
  //  return this.summary('homeTeamLineupStats', 'freeThrowMade');
  //}),
  //homeLineupFT: Ember.computed.sum('homeTeamLineupStats.@each.freeThrowMade'),

});
