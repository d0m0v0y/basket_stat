App.ByEventChartComponent = App.CommonChartComponent.extend({
  data: null,
  //team: null,
  chartName: null,
  event: null,

  sortOrder: Ember.computed('event', function(){
    return [this.get('event') + ':desc'];
  }),
  orderedData: Ember.computed.sort('data', 'sortOrder'),

  statsData: Ember.computed('data.@each.playerName', function(){
    var self = this;
    return this.get('orderedData').map(function(item){
      return [
        item.get('playerName'),
        item.get(self.get('event'))
      ]
    });
  }),

  chartData: Ember.computed('data', function(){
    return [{
      name: this.get('chartName'),
      data: this.get('statsData'),
      dataLabels: {
        enabled: true
      }
    }]
  }),

  chartOptions: {
    chart: {
      type: 'column'
    },
    title: {
      text: ''
    },
    credits: {
      enabled: false
    },
    xAxis: {
      type: 'category',
      labels: {
        rotation: -45,
        style: {
          fontSize: '13px',
          fontFamily: 'Verdana, sans-serif'
        }
      }
    },

    yAxis: {
      title: {
        text: 'Values'
      }
    },
    legend: {
      enabled: false
    }
  }
});