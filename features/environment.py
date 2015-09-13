from selenium import webdriver
from functools import partial
import os

def before_all(context):

    context.server_host = "127.0.0.1"
    context.server_port = "3000"

    # Utility function: Build full URL from given path
    def build_url_from_path(path):
        return "http://" + context.server_host + ":" + context.server_port + path
    context.build_url_from_path = build_url_from_path

    # Implement driver's "get" method to prepend path with server URL
    def driver_get_path(browser, path):
        browser.get(
            "http://{0}:{1}".format(context.server_host, context.server_port) + path)

    context.browser = webdriver.Chrome()
    context.browser.get_path = partial(driver_get_path, context.browser)


def after_all(context):
    context.browser.quit()
