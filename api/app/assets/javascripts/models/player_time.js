App.PlayerTime = DS.Model.extend({
  game: DS.belongsTo('game'),
  player: DS.belongsTo('player'),
  inTime: DS.attr(),
  outTime: DS.attr()
});