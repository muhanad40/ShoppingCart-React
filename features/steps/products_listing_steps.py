from hamcrest import assert_that, equal_to, raises, calling
from selenium.common.exceptions import NoSuchElementException
import time
import re

@given(u'I am on the homepage')
def step_impl(context):
    context.browser.get_path("/")

@then(u'I should see a list of products')
def step_impl(context):
    products = context.browser.find_elements_by_class_name("product")
    assert_that(len(products), equal_to(13))


@then(u'I should not see the "Add to Cart" button on out of stock products')
def step_impl(context):
    products = context.browser.find_elements_by_class_name("product")
    for product in products:
        if re.search("product-out-of-stock", product.get_attribute("class")):
            label = product.find_element_by_class_name("add-to-cart-btn-wrapper").text
            assert_that(label, equal_to("Out of stock"))
