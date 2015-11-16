App.GameTimerComponent = Ember.Component.extend({
  timer: null,
  startTime: null,
  timeout: null,
  pauseTime: 0,
  mils: null,
  paused: false,
  count: 0,
  currentTime: null,
  startDisabled: false,

  isNotStarted: function(){
    return Ember.isBlank(this.get('startTime'))
  }.property('startTime'),

  formattedTime: function () {
    return moment.duration(this.get('mils')).format('hh:mm:ss', {trim: false})
  }.property('mils'),

  timeDidChanged: function(){
    this.set('currentTime', this.get('formattedTime'))
  }.observes('formattedTime'),

  clock: function () {
    var self = this;
    var curTime = new Date();
    var startTime = self.get('startTime');
    var pauseTime = self.get('pauseTime');
    self.set('mils', (curTime - startTime) + pauseTime);
    self.set('timeout', Ember.run.later(self, self.clock, 100));
  },

  startTimer: function(){
    this.set('startTime', new Date());
    this.clock();
  },

  actions: {
    start: function () {
      this.startTimer();
      this.sendAction();
    },

    pause: function(){
      //Ember.Logger.info('pause timer: ', this.get('paused'));
      if (this.get('paused') == false) {
        //Ember.Logger.info('set pause');
        this.toggleProperty('paused');
        Ember.run.cancel(this.get('timeout'));
        this.set('pauseTime', this.get('mils'));
      } else {
        //Ember.Logger.info('unpause');
        this.toggleProperty('paused');
        this.startTimer();
      }
    },

    stop: function(){
      this.set('paused', false);
      Ember.run.cancel(this.get('timeout'));
      this.set('pauseTime', 0);
      this.set('mils', 0);
    }
  }



});

