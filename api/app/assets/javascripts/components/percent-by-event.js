App.PercentByEventComponent = Ember.Component.extend({
  made: Ember.computed('stats', function(){
    var event = this.get('event-made');
    return this.get('stats').reduce(function(prevVal, row){
      return prevVal + row.get(event)
    }, 0)
  }),

  total: Ember.computed('stats', function(){
    var event = this.get('event-total');
    return this.get('stats').reduce(function(prevVal, row){
      return prevVal + row.get(event)
    }, 0)
  }),

  result: Ember.computed('made', 'total', function() {
    return (this.get('made') / this.get('total') * 100).toFixed(2);
  })
});