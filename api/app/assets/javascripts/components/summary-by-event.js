App.SummaryByEventComponent = Ember.Component.extend({
  result: Ember.computed('stats', function(){
    var event = this.get('event');
    return this.get('stats').reduce(function(prevVal, row){
      return prevVal + row.get(event)
    }, 0)
  })
});