@cart
Feature: Cart

	@cart-empty
	Scenario: No items in cart when empty
		Given I am on the shopping cart page
		Then I should see an empty cart

	@cart-add
	Scenario: Items in cart when items are added
		Given I have added products to my shopping cart
		And I am on the shopping cart page
		Then I should see those items added

	@cart-subtotal
	Scenario: Check sub-total
		Given I have added products to my shopping cart
		And I am on the shopping cart page
		Then I should see the correct sub-total

	Scenario: Check total
		Given I am on the shopping cart page
		Then I should see stuff

	Scenario: Add voucher and check total
		Given I am on the shopping cart page
		Then I should see stuff

	Scenario: Check cart widget total
		Given I am on the shopping cart page
		Then I should see stuff
