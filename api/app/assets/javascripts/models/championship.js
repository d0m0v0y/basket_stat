App.Championship = DS.Model.extend({
  name: DS.attr(),

  seasons: DS.hasMany('season', { async: true })
});