App.GamesStatsController = Ember.Controller.extend({
  homeTeamStats: function(){
    var team = this.get('model.homeTeam');
    var stats = this.get('model.statistics');
    return stats.filter(function(item){
      return item.get('team') == team;
    })
  }.property('model'),

  awayTeamStats: function () {
    var team = this.get('model.awayTeam');
    var stats = this.get('model.statistics');
    return stats.filter(function (item) {
      return item.get('team') == team;
    })
  }.property('model')
});