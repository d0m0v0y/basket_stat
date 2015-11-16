App.PlayerController = Ember.Controller.extend({
  playerPositions: [
    { positionId: 'point_guard', positionName: 'Guard'},
    { positionId: 'shooting_guard', positionName: 'Shooting Guard' },
    { positionId: 'small_forward', positionName: 'Small Forward' },
    { positionId: 'power_forward', positionName: 'Power Forward'},
    { positionId: 'center', positionName: 'Center' }
  ]
});