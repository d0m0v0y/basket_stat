App.GamesStatsController = Ember.Controller.extend({
  homeTeamStats: function(){
    return this.getStats('model.homeTeam');
  }.property('model'),

  awayTeamStats: function () {
    return this.getStats('model.awayTeam');
  }.property('model'),

  getStats: function(dataSource) {
    var team = this.get(dataSource);
    var stats = this.get('model.statistics');
    return stats.filter(function (item) {
      return item.get('team.id') == team.get('id');
    })
  }
});