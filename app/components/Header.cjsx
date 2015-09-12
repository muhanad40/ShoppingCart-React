React = require('react')
Fluxxor = require("fluxxor")
CartWidget = require("./CartWidget.cjsx")

FluxMixin = Fluxxor.FluxMixin(React)
StoreWatchMixin = Fluxxor.StoreWatchMixin

Header = React.createClass

  mixins: [FluxMixin, StoreWatchMixin("CartStore")]

  getStateFromFlux: ->
    flux = @getFlux()
    return {
      CartStore: flux.store("CartStore").getState()
    }

  render: ->
    return (
      <nav className="navbar navbar-default">
        <div className="container-fluid">
          <div className="nav navbar-nav navbar-right">
            <CartWidget />
          </div>
          <div className="navbar-header">
            <a className="navbar-brand" href="#">
              Store.com
            </a>
          </div>
        </div>
      </nav>
    )

module.exports = Header