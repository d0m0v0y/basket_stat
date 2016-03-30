App.GameLineChartComponent = App.CommonChartComponent.extend({
  gameData: null,

  formatData: function(events){
    var totalPoints = 0;
    var data = [
      [moment('00:00:00', 'hh:mm:ss').valueOf(), totalPoints]
    ];

    events.forEach(function(item){
      var time = moment(item.get('eventTime'), 'hh:mm:ss').valueOf();
      var point;
      switch(item.get('eventCode')){
        case 'ftm':
          point = 1;
          break;
        case 'fgm':
          point = 2;
          break;
        case 'fgm3':
          point = 3;
          break;
      }
      totalPoints += point;
      data.push([time, totalPoints]);
    });
    return data;
  },

  homeTeamScoreEvents: Ember.computed('gameData.events', 'gameData.homeTeam.name', function(){
    var self = this;
    var events = this.get('gameData.gameEvents').filter(function(event){
      return Ember.isEqual(event.get('player.team.id'), self.get('gameData.homeTeam.id')) &&
          ['ftm', 'fgm', 'fgm3'].contains(event.get('eventCode'))
    }).sortBy('eventTime');

    return this.formatData(events);
  }),

  awayTeamScoreEvents: Ember.computed('gameData.events', 'gameData.awayTeam.name', function(){
    var self = this;
    var events = this.get('gameData.gameEvents').filter(function(event){
      return Ember.isEqual(event.get('player.team.id'), self.get('gameData.awayTeam.id')) &&
        ['ftm', 'fgm', 'fgm3'].contains(event.get('eventCode'))
    }).sortBy('eventTime');

    return this.formatData(events);
  }),

  chartData: Ember.computed('gameData.homeTeam.name', 'gameData.awayTeam.name', function(){
    return [
      {
        name: this.get('gameData.homeTeam.name'),
        data: this.get('homeTeamScoreEvents')
      },
      {
        name: this.get('gameData.awayTeam.name'),
        data: this.get('awayTeamScoreEvents')
      }
    ]
  }),

  chartOptions: {
    chart: {
      type: 'line'
    },
    title: {
      text: 'Game Line'
    },
    subtitle: {
      text: 'points by time'
    },
    xAxis: {
      type: 'datetime',
      //dateTimeLabelFormats : {
      //  hour: '%I %p',
      //  minute: '%I:%M %p'
      //},
      title: {
        text: 'Time'
      }
    },
    yAxis: {
      title: {
        text: 'Points'
      },
      min: 0
    },
    tooltip: {
      headerFormat: '<b>{series.name}</b><br>',
      pointFormat: '{point.x:%H:%M:%S} - {point.y}'
    },

    plotOptions: {
      line: {
        marker: {
          enabled: true
        }
      }
    }
  }
});