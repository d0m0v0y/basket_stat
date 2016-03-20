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
  getStats: function(dataSource) {
    var team = this.get(dataSource);
    var stats = this.get('statistics');
    return stats.filter(function (item) {
      return item.get('team.id') == team.get('id');
    })
  },

  homeTeamStatsUnordered: Ember.computed(function(){
    return this.getStats('homeTeam');
  }),
  awayTeamStatsUnordered: Ember.computed(function () {
    return this.getStats('awayTeam');
  }),

  lineupOrder: ['lineup:desc'],
  homeTeamStats: Ember.computed.sort('homeTeamStatsUnordered', 'lineupOrder'),
  awayTeamStats: Ember.computed.sort('awayTeamStatsUnordered', 'lineupOrder'),


});
