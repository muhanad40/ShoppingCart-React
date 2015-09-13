from hamcrest import assert_that, equal_to, has_item
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
    # add only the first 4 products
    products_to_add = products[0:4]
    context.cart_item_titles = [product.find_element_by_class_name("product-title").text for product in products_to_add]
    for product in products_to_add:
        try:
            add_to_cart_button = product.find_element_by_class_name("add-to-cart-btn")
            if add_to_cart_button:
                add_to_cart_button.click()
        except:
            # may not find element because item is out of stock
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
    assert_that(subtotal, equal_to(194))
