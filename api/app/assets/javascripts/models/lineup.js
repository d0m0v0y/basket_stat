App.Lineup = DS.Model.extend({
  game: DS.belongsTo('game', { async: true }),
  team: DS.belongsTo('team', { async: true }),
  player: DS.belongsTo('player', { async: true })
});