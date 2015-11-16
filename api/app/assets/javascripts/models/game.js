App.Game = DS.Model.extend({
  homeTeam: DS.belongsTo('team'),
  awayTeam: DS.belongsTo('team'),

  date: DS.attr('date'),
  startedAt: DS.attr('date'),
  finishedAt: DS.attr('date'),

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
  }.property('id')



});
