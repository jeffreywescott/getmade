Dispatcher = require("flux").Dispatcher
assign = require("object-assign")
AppDispatcher = assign(new Dispatcher(),

  handleViewAction: (action) ->
    @dispatch
      source: "VIEW_ACTION"
      action: action
)

module.exports = AppDispatcher
