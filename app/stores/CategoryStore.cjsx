Fluxxor = require("fluxxor")

CategoryStore = Fluxxor.createStore({
  initialize: ->
    @categories = [
      {
        id: 1
        slug: "womens-footware"
        name: "Women's footwear"
      }
      {
        id: 2
        slug: "mens-footwear"
        name: "Men's footwear"
      }
      {
        id: 3
        slug: "womens-casualwear"
        name: "Women's casualwear"
      }
      {
        id: 4
        slug: "mens-casualwear"
        name: "Men's casualwear"
      }
      {
        id: 5
        slug: "mens-formalwear"
        name: "Men's formalwear"
      }
      {
        id: 6
        slug: "womens-formalwear"
        name: "Women's formalwear"
      }
    ]

  getState: ->
    return {
      categories: @categories
    }
})

module.exports = CategoryStore