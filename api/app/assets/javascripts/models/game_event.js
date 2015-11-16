App.GameEvent = DS.Model.extend({
  eventCode: DS.attr('string'),
  eventTime: DS.attr('string'),
  player: DS.belongsTo('player'),
  gameId: DS.attr()
});