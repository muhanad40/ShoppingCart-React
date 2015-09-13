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

	@cart-total
	Scenario: Check total
		Given I have added products to my shopping cart
		And I am on the shopping cart page
		Then I should see the correct total

	@cart-invalid-voucher
	Scenario: Invalid voucher error
		Given I have added products to my shopping cart
		And I am on the shopping cart page
		And I add an invalid voucher
		Then I should see an error message

	@cart-remove-item
	Scenario: Remove a product from shopping cart
		Given I have added products to my shopping cart
		And I am on the shopping cart page
		And I remove an item from the cart
		Then the item should be removed

	@cart-valid-voucher
	Scenario: Add voucher and check total
		Given I have added products to my shopping cart
		And I am on the shopping cart page
		And I add a valid voucher
		Then I should see the discount being applied

	@cart-widget
	Scenario: Check cart widget total before voucher is applied
		Given I have added products to my shopping cart
		Then I should see the correct cart total cost in the widget

	@cart-widget-voucher
	Scenario: Check cart widget total when voucher is applied
		Given I have added products to my shopping cart
		And I am on the shopping cart page
		And I add a valid voucher
		Then I should see the total in the widget with discount applied
