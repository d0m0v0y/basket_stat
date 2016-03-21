App.CompareSummaryStatsComponent = Ember.Component.extend({
  homeTeamStats: Ember.computed.alias('data.homeTeamStats'),
  homeTeamName: Ember.computed.alias('data.homeTeam.name')
});