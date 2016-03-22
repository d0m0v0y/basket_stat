App.CompareSummaryStatsComponent = Ember.Component.extend({
  homeTeamStats: Ember.computed.alias('data.homeTeamStats'),
  homeTeamName: Ember.computed.alias('data.homeTeam.name'),
  homeTeamLineupStats: Ember.computed.filterBy('homeTeamStats', 'lineup', true),
  homeTeamBenchStats: Ember.computed.filterBy('homeTeamStats', 'lineup', false),
  awayTeamStats: Ember.computed.alias('data.awayTeamStats'),
  awayTeamName: Ember.computed.alias('data.awayTeam.name'),
  awayTeamLineupStats: Ember.computed.filterBy('awayTeamStats', 'lineup', true),
  awayTeamBenchStats: Ember.computed.filterBy('awayTeamStats', 'lineup', false),
});
