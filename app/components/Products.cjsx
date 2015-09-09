React = require('react')
Product = require('./Product.cjsx')

ProductsComponent = React.createClass

  render: ->
    productComponents = @props.products.map((product)=>
      return (
        <div><Product key={product.id} details={product} /></div>
      )
    )
    return (
      <div>
        {productComponents}
      </div>
    )

module.exports = ProductsComponent