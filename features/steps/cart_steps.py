from hamcrest import assert_that, equal_to, has_item, is_not
import time

@given(u'I am on the shopping cart page')
def step_impl(context):
    context.browser.get_path("/#/cart")

@then(u'I should see an empty cart')
def step_impl(context):
    no_items_msg_element = context.browser.find_element_by_id("no-cart-items-msg")
    assert_that(no_items_msg_element.is_displayed(), equal_to(True))



@given(u'I have added products to my shopping cart')
def step_impl(context):
    context.browser.get_path("/")
    products = context.browser.find_elements_by_class_name("product")
    context.products_to_add = products[0:4]
    context.cart_item_titles = [product.find_element_by_class_name("product-title").text for product in context.products_to_add]
    for product in context.products_to_add:
        try:
            add_to_cart_button = product.find_element_by_class_name("add-to-cart-btn")
            if add_to_cart_button:
                add_to_cart_button.click()
        except:
            return

@then(u'I should see those items added')
def step_impl(context):
    cart_items = context.browser.find_elements_by_class_name("cart-item")
    for item in cart_items:
        item_title = item.find_element_by_class_name("cart-item-title")
        assert_that(context.cart_item_titles, has_item(item_title.text))


@then(u'I should see the correct sub-total')
def step_impl(context):
    cart_items = context.browser.find_elements_by_class_name("cart-item")
    subtotal = 0
    for item in cart_items:
        cart_item_quantity = int(item.find_element_by_class_name("cart-item-quantity").text)
        cart_item_total_price = int(item.find_element_by_class_name("cart-item-total-price").text)
        subtotal += cart_item_total_price * cart_item_quantity
    subtotal_element = context.browser.find_element_by_id("cart-subtotal")
    assert_that(int(subtotal_element.text), equal_to(subtotal))


@then(u'I should see the correct total')
def step_impl(context):
    cart_items = context.browser.find_elements_by_class_name("cart-item")
    total = 0
    for item in cart_items:
        cart_item_quantity = int(item.find_element_by_class_name("cart-item-quantity").text)
        cart_item_total_price = int(item.find_element_by_class_name("cart-item-total-price").text)
        total += cart_item_total_price * cart_item_quantity
    total_element = context.browser.find_element_by_id("cart-total")
    assert_that(int(total_element.text), equal_to(total))


@given(u'I add an invalid voucher')
def step_impl(context):
    voucher_input_field = context.browser.find_element_by_id("voucher-input")
    voucher_input_field.send_keys("invalid-voucher--")
    add_voucher_btn = context.browser.find_element_by_id("add-voucher-btn")
    add_voucher_btn.click()

@then(u'I should see an error message')
def step_impl(context):
    error_element = context.browser.find_element_by_class_name("alert-danger")
    assert_that(error_element.is_displayed(), equal_to(True))


@given(u'I remove an item from the cart')
def step_impl(context):
    cart_items = context.browser.find_elements_by_class_name("cart-item")
    context.removed_cart_item_title = cart_items[0].find_element_by_class_name("cart-item-title")
    remove_cart_item_btn = cart_items[0].find_element_by_class_name("remove-cart-item-btn")
    remove_cart_item_btn.click()

@then(u'the item should be removed')
def step_impl(context):
    cart_items = context.browser.find_elements_by_class_name("cart-item")
    for item in cart_items:
        item_title = item.find_elements_by_class_name("cart-item-title")
        assert_that(item_title, is_not(equal_to(context.removed_cart_item_title)))


@given(u'I add a valid voucher')
def step_impl(context):
    voucher_input_field = context.browser.find_element_by_id("voucher-input")
    voucher_input_field.send_keys("DELOITTE2015")
    voucher_input_field.submit()

@then(u'I should see the discount being applied')
def step_impl(context):
    subtotal = int(context.browser.find_element_by_id("cart-subtotal").text)
    total_element = context.browser.find_element_by_id("cart-total")
    expected_discounted_total = subtotal - 5
    assert_that(int(total_element.text), equal_to(expected_discounted_total))


@then(u'I should see the correct cart total cost in the widget')
def step_impl(context):
    total_products_cost = 0
    for product in context.products_to_add:
        product_quantity = 1
        product_total_price = int(product.find_element_by_class_name("product-price").text)
        total_products_cost += product_total_price * product_quantity

    cart_widget = context.browser.find_element_by_id("cart-widget")
    total_items = int(cart_widget.find_element_by_id("cart-widget-total-items").text)
    cart_total = int(cart_widget.find_element_by_id("cart-widget-total-cost").text)
    assert_that(len(context.products_to_add), equal_to(total_items))
    assert_that(total_products_cost, equal_to(cart_total))


@then(u'I should see the total in the widget with discount applied')
def step_impl(context):
    subtotal = int(context.browser.find_element_by_id("cart-subtotal").text)
    discount = 5
    expected_total = subtotal - discount
    cart_widget = context.browser.find_element_by_id("cart-widget")
    total_items = int(cart_widget.find_element_by_id("cart-widget-total-items").text)
    cart_total = int(cart_widget.find_element_by_id("cart-widget-total-cost").text)
    assert_that(total_items, equal_to(4))
    assert_that(cart_total, equal_to(expected_total))
