React = require("react/addons")
Fluxxor = require("fluxxor")
TestUtils = React.addons.TestUtils

CartActions = require("../../app/actions/CartActions.cjsx")
ProductsStore = require("../../app/stores/ProductsStore.cjsx")
CartStore = require("../../app/stores/CartStore.cjsx")
VoucherStore = require("../../app/stores/VoucherStore.cjsx")

stores = {
  CartStore: new CartStore()
  ProductsStore: new ProductsStore()
  VoucherStore: new VoucherStore()
}
flux = new Fluxxor.Flux(stores, CartActions)

testProductsList = [
  {
    id: 1
    title: "Almond Toe Court Shoes, Patent Blac"
    categoryId: 1
    price: {
      before: null
      now: 99
    }
    stock: 2
  }
  {
    id: 2
    title: "Suede Shoes, Blue"
    categoryId: 1
    price: {
      before: null
      now: 42
    }
    stock: 4
  }
  {
    id: 3
    title: "Leather Driver Saddle Loafers, Tan"
    categoryId: 2
    price: {
      before: null
      now: 34
    }
    stock: 12
  }
]

describe("CartStore", ->

  beforeEach(->
    stores.CartStore.items = []
    stores.CartStore.vouchers = []
  )

  it("should add a product to the cart", ->
    flux.actions.addItemToCart(testProductsList[0])
    flux.actions.addItemToCart(testProductsList[2])
    expectedCartItems = [
      {
        product: testProductsList[0]
        quantity: 1
      }
      {
        product: testProductsList[2]
        quantity: 1
      }
    ]
    cartItems = stores.CartStore.getState().items
    expect(cartItems).toEqual(expectedCartItems)
  )

  it("should increment an item's quantity if it's already in the cart", ->
    flux.actions.addItemToCart(testProductsList[0])
    flux.actions.addItemToCart(testProductsList[2])
    flux.actions.addItemToCart(testProductsList[2])
    expectedCartItems = [
      {
        product: testProductsList[0]
        quantity: 1
      }
      {
        product: testProductsList[2]
        quantity: 2
      }
    ]
    cartItems = stores.CartStore.getState().items
    expect(cartItems).toEqual(expectedCartItems)
  )

  it("should return total number of items in the cart", ->
    flux.actions.addItemToCart(testProductsList[0])
    flux.actions.addItemToCart(testProductsList[1])
    flux.actions.addItemToCart(testProductsList[2])
    flux.actions.addItemToCart(testProductsList[2])
    expectedTotalCartItems = 4
    totalCartItems = stores.CartStore.getTotalItems()
    expect(totalCartItems).toEqual(expectedTotalCartItems)
  )

  it("should remove an item from the cart", ->
    cartItems = [
      {
        quantity: 1
        product: testProductsList[0]
      }
      {
        quantity: 1
        product: testProductsList[1]
      }
      {
        quantity: 1
        product: testProductsList[2]
      }
      {
        quantity: 1
        product: testProductsList[2]
      }
    ]
    stores.CartStore.items = cartItems
    productIdToRemove = testProductsList[2].id
    expectedTotalCartItems = 2
    flux.actions.removeItemFromCart(productIdToRemove)
    totalCartItems = stores.CartStore.getTotalItems()
    expect(totalCartItems).toEqual(expectedTotalCartItems)
  )

  it("should calculate the total cost of the items", ->
    cartItems = [
      {
        quantity: 1
        product: testProductsList[0]
      }
      {
        quantity: 3
        product: testProductsList[1]
      }
      {
        quantity: 2
        product: testProductsList[2]
      }
    ]
    stores.CartStore.items = cartItems
    expectedCartSubTotalCost = 293
    totalCartItems = stores.CartStore.getSubTotalCost()
    expect(totalCartItems).toEqual(expectedCartSubTotalCost)
  )

  it("should add a voucher to the cart", ->
    voucher = "DELOITTE2015"
    flux.actions.addVoucherToCart(voucher)
    cartVouchers = stores.CartStore.getState().vouchers
    expect(cartVouchers).toEqual([voucher])
  )

  it("should add a voucher to the cart only once", ->
    voucher = "DELOITTE2015"
    flux.actions.addVoucherToCart(voucher)
    flux.actions.addVoucherToCart(voucher)
    cartVouchers = stores.CartStore.getState().vouchers
    expect(cartVouchers).toEqual([voucher])
  )

  it("should remove a voucher from the cart", ->
    voucher = "DELOITTE2015"
    stores.CartStore.vouchers = [voucher]
    flux.actions.removeVoucherFromCart(voucher)
    cartVouchers = stores.CartStore.getState().vouchers
    expect(cartVouchers).toEqual([])
  )

  it("should throw an error if an invalid voucher is added", ->
    invalidVoucher = "invalid-voucher"
    expect(flux.actions.addVoucherToCart.bind(null, invalidVoucher)).toThrow(new Error("The voucher you've entered is invalid"))
  )

  it("should apply voucher and deduct 5.00 GBP", ->
    # set up vouchers
    testVouchers = [
      {
        id: 1
        code: "DELOITTE2015"
        rules: []
        discount: 5.00
      }
    ]
    stores.VoucherStore.vouchers = testVouchers
    # add items to cart
    cartItems = [
      {
        quantity: 1
        product: testProductsList[0]
      }
      {
        quantity: 3
        product: testProductsList[1]
      }
    ]
    stores.CartStore.items = cartItems
    # apply voucher
    flux.actions.addVoucherToCart("DELOITTE2015")
    
    expectedCartTotalCost = parseFloat(225 - 5.00).toFixed(2)/1
    expect(stores.CartStore.getTotalCost()).toEqual(expectedCartTotalCost)
  )

  it("should not apply voucher when cart total is less than or equal to 50.00 GBP", ->
    # set up vouchers
    testVouchers = [
      {
        id: 1
        code: "RABBIT9"
        rules: [
          {minTotal: 50.01}
        ]
        discount: 10.00
      }
    ]
    stores.VoucherStore.vouchers = testVouchers
    # add items to cart
    cartItems = [
      {
        quantity: 1
        product: testProductsList[1]
      }
    ]
    stores.CartStore.items = cartItems
    # apply voucher
    flux.actions.addVoucherToCart("RABBIT9")

    expectedCartTotalCost = 42
    expect(stores.CartStore.getTotalCost()).toEqual(expectedCartTotalCost)
  )

  it("should apply voucher and deduct 10.00 GBP when cart total is more than 50.00 GBP", ->
    # set up vouchers
    testVouchers = [
      {
        id: 1
        code: "RABBIT9"
        rules: [
          {minTotal: 50.01}
        ]
        discount: 10.00
      }
    ]
    stores.VoucherStore.vouchers = testVouchers
    # add items to cart
    cartItems = [
      {
        quantity: 2
        product: testProductsList[0]
      }
      {
        quantity: 10
        product: testProductsList[1]
      }
    ]
    stores.CartStore.items = cartItems
    # apply voucher
    flux.actions.addVoucherToCart("RABBIT9")

    expectedCartTotalCost = parseFloat(618 - 10.00).toFixed(2)/1
    expect(stores.CartStore.getTotalCost()).toEqual(expectedCartTotalCost)
  )

  it("should apply voucher and deduct 15.00 GBP when cart total is more than 75.00 GBP and cart contains items that belong to specific categories", ->
    # set up vouchers
    testVouchers = [
      {
        id: 3
        code: "FOOT15"
        rules: [
          {minTotal: 75.01}
          {categoryIds: [1,2]}
        ]
        discount: 15.00
      }
    ]
    stores.VoucherStore.vouchers = testVouchers
    # add items to cart
    cartItems = [
      {
        quantity: 2
        product: testProductsList[0]
      }
      {
        quantity: 20
        product: testProductsList[1]
      }
    ]
    stores.CartStore.items = cartItems
    # apply voucher
    flux.actions.addVoucherToCart("FOOT15")

    expectedCartTotalCost = parseFloat(1038 - 15.00).toFixed(2)/1
    expect(stores.CartStore.getTotalCost()).toEqual(expectedCartTotalCost)
  )

  it("should add product to the cart with quantity no more than its available stock", ->
    flux.actions.addItemToCart(testProductsList[0])
    flux.actions.addItemToCart(testProductsList[0])
    flux.actions.addItemToCart(testProductsList[0])
    flux.actions.addItemToCart(testProductsList[0])
    expectedCartItems = [
      {
        product: testProductsList[0]
        quantity: 2
      }
    ]
    expect(stores.CartStore.getState().items).toEqual(expectedCartItems)
  )

)