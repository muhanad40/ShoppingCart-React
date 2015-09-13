@products
Feature: Products listing

	@products-listing
    Scenario: Products listing
        Given I am on the homepage
        Then I should see a list of products

    @products-out-of-stock
	Scenario: Unable to add Out of Stock products to shopping cart
		Given I am on the homepage
		Then I should not see the "Add to Cart" button on out of stock products