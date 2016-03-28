App.CompareSummaryChartsComponent = App.CommonChartComponent.extend({
  //layoutName: 'components/common-chart',
  gameData: null,
  chartKeys: [
    'freeThrowMade', 'freeThrowPercent',
    'fieldGoalMade', 'fieldGoalPercent',
    'threePointMade', 'threePointPercent',
    'totalRebounds', 'fouls', 'efficiency'
  ],

  homeTeamName: Ember.computed.alias('gameData.homeTeam.name'),
  awayTeamName: Ember.computed.alias('gameData.awayTeam.name'),

  homeStats: Ember.computed('gameData', 'homeTeamName', function() {
    return App.StatisticSummary.create({
      data: this.get('gameData'),
      team: this.get('gameData.homeTeam'),
      chartKeys: this.get('chartKeys'),
      name: this.get('homeTeamName')
    })
  }),

  awayStats: Ember.computed('gameData', 'awayTeamName', function() {
    return App.StatisticSummary.create({
      data: this.get('gameData'),
      team: this.get('gameData.awayTeam'),
      chartKeys: this.get('chartKeys'),
      name: this.get('awayTeamName')
    })
  }),

  chartData: Ember.computed(
    'homeStats.chartData',
    'awayStats.chartData',
    function () {
      return [
        this.get('homeStats.chartData'),
        this.get('awayStats.chartData')
      ]
    }
  ),

  chartOptions: {
    chart: {
      type: 'column'
    },
    title: {
      text: 'Overall Stats'
    },
    xAxis: {
      categories: [
        'Free Throw Points', 'Free Throws %', 'Field Goal Points', 'Field Goal %', '3-Points', '3-Points %',
        'Rebounds', 'Fouls', 'Efficiency'
      ]
    },
    yAxis: {
      title: {
        text: 'Values'
      },
      labels: {
        overflow: 'justify'
      },
      stackLabels: {
        enabled: true,
        style: {
          fontWeight: 'bold',
          fontSize: '16px',
          color: (Highcharts.theme && Highcharts.theme.textColor) || 'gray'
        }
      }
    },

    plotOptions: {
      column: {
        dataLabels: {
          enabled: true
        }
      }
    },
  },
});
