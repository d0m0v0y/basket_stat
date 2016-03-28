App.PointsChartComponent = App.CommonChartComponent.extend({
  gameData: null,
  team: null,
  chartKeys: ['freeThrowMade', 'fieldGoalMade', 'threePointMade'],

  teamName: Ember.computed.alias('team.name'),
  chartTitle: Ember.computed('teamName', function(){
    return this.get('teamName') + ' Points'
  }),

  teamStat: Ember.computed('gameData', 'teamName', function() {
    return App.StatisticSummary.create({
      data: this.get('gameData'),
      team: this.get('team'),
      //chartKeys: this.get('chartKeys'),
      name: this.get('teamName')
    })
  }),

  chartData: Ember.computed('teamStat', function () {
      return [{
        name: 'Points',
        colorByPoint: true,
        data: [
          {
            name: 'Free Throws',
            y: this.get('teamStat.freeThrowMade')
          },
          {
            name: 'Field Goals',
            y: this.get('teamStat.fieldGoalMade')
          },
          {
            name: '3-Point',
            y: this.get('teamStat.threePointMade')
          }
        ]
      }]
    }
  ),

  chartOptions: Ember.computed('team.name', function() {
    return {
      chart: {
        type: 'pie',
        width: 600
      },
      title: {
        text: ''
      },

      plotOptions: {
        pie: {
          allowPointSelect: true,
          cursor: 'pointer',
          dataLabels: {
            enabled: true,
            format: '<b>{point.name}</b>: {point.percentage:.1f} %',
            style: {
              color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
            }
          }
        }
      }
    }
  })
});