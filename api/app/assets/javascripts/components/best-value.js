App.BestValueComponent = Ember.Component.extend({
  tagName: 'td',
  classNameBindings: ['isBestValue:success'],

  //allValues: Ember.computed.mapBy(this.get('stats'), this.get('event')),
  allValues: Ember.computed('stats', 'event', function(){
    return this.get('stats').mapBy(this.get('event'));
  }),

  bestValue: Ember.computed.max('allValues'),

  //isBestValue: Ember.computed.equal('bestValue', 'val')
  isBestValue: Ember.computed('bestValue', 'val', function(){
    return Ember.isEqual(this.get('bestValue'), this.get('val')) &&
      this.get('val') !== 0;
  }),

  //valueToDisplay: Ember.computed('val', 'event', function(){
  //
  //})
});