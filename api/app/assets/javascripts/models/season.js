App.Season = DS.Model.extend({
  name: DS.attr(),

  championship: DS.belongsTo('championship'),
  teams: DS.hasMany('team')
});