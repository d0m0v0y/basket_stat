App.Player = DS.Model.extend({
  firstName: DS.attr('string'),
  lastName: DS.attr('string'),
  number: DS.attr(),
  position: DS.attr('string'),
  weight: DS.attr(),
  height: DS.attr(),
  birthDate: DS.attr('date'),

  team: DS.belongsTo('team', { async: true}),

  fullName: function () {
    return this.get('firstName') + ' ' + this.get('lastName');
  }.property('firstName', 'lastName'),

  nameWithNumber: function (){
    return "#%@1, %@2".fmt(this.get('number'), this.get('fullName'))
  }.property('fullName', 'number'),

  teamName: Ember.computed.alias('team.name')
});