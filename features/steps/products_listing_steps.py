from hamcrest import assert_that, equal_to
import time

@given(u'I am on the homepage')
def step_impl(context):
    context.browser.get_path("/")

@then(u'I should see a list of products')
def step_impl(context):
    products = context.browser.find_elements_by_class_name("product")
    assert_that(len(products), equal_to(13))