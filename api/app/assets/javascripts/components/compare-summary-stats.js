App.CompareSummaryStatsComponent = Ember.Component.extend({
  data: null,

  homeTeamName: Ember.computed.alias('data.homeTeam.name'),
  awayTeamName: Ember.computed.alias('data.awayTeam.name'),

  homeTeamStats: Ember.computed.alias('data.homeTeamStats'),
  awayTeamStats: Ember.computed.alias('data.awayTeamStats'),

  homeTeamLineupStats: Ember.computed.filterBy('homeTeamStats', 'lineup', true),
  homeTeamBenchStats: Ember.computed.filterBy('homeTeamStats', 'lineup', false),

  awayTeamLineupStats: Ember.computed.filterBy('awayTeamStats', 'lineup', true),
  awayTeamBenchStats: Ember.computed.filterBy('awayTeamStats', 'lineup', false),

});
