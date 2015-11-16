var get = Ember.get, set = Ember.set;

Ember.Select.reopen({
  optionDisabledPath: null
});

Ember.SelectOption.reopen({
  attributeBindings: ['disabled'],

  init: function () {
    this.disabledPathDidChange();
    this._super();
  },

  disabledPathDidChange: Ember.observer(function () {
    var valuePath = get(this, 'parentView.optionDisabledPath');

    if (!valuePath) {
      return;
    }

    Ember.defineProperty(this, 'disabled', Ember.computed(function () {
      return get(this, valuePath);
    }).property(valuePath));
  })
});