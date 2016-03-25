App.HighChartsComponent = Ember.Component.extend(App.HighchartsThemeMixin, {
  classNames:   [ 'highcharts-wrapper' ],
  content:      undefined,
  chartOptions: undefined,
  chart:        null,

  buildOptions: Em.computed('chartOptions', 'content.@each.isLoaded', function() {
    var chartContent, chartOptions, defaults;
    chartOptions = this.getWithDefault('chartOptions', {});
    chartContent = this.get('content.length') ? this.get('content') : [
      {
        id: 'noData',
        data: 0,
        color: '#aaaaaa'
      }
    ];
    defaults = {
      series: chartContent
    };
    return Em.merge(defaults, chartOptions);
  }),

  _renderChart: (function() {
    this.drawLater();
    this.buildTheme();
  }).on('didInsertElement'),

  contentDidChange: Em.observer('content.@each.isLoaded', function() {
    var chart;
    if (!(this.get('content') && this.get('chart'))) {
      return;
    }
    chart = this.get('chart');

    this.get('content').forEach(function(series, idx) {
      var _ref;
      if ((_ref = chart.get('noData')) != null) {
        _ref.remove();
      }
      if (chart.series[idx]) {

        chart.series[idx].update({ name: series.name, data: series.data, stack: series.stack }, false);
      } else {
        chart.addSeries(series);
      }
    });
    chart.redraw();
  }),

  drawLater: function() {
    Ember.run.scheduleOnce('afterRender', this, 'draw');
  },

  draw: function() {
    var options;
    options = this.get('buildOptions');
    this.set('chart', this.$().highcharts(options).highcharts());
  },

  _destroyChart: (function() {
    this._super();
    this.get('chart').destroy();
  }).on('willDestroyElement')
});
