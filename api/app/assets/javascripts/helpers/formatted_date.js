Ember.Handlebars.helper('formattedDate', function (value, options) {
  return new Ember.Handlebars.SafeString(moment(value).format('ll'));
});