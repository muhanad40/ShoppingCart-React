Shopping Cart with ReactJs
==========================

Requirements:
-------------
- Python
- NPM/Node
- ChromeWebDriver

Project setup:
-------------
Once you have the requirements installed, run the following commands:
```bash
pip install -r requirements-dev.txt
npm install
```

To run the app:
First bundle the app code:
```bash
./node_modules/.bin/gulp webpack:app
```
Once gulp finishes, run the following command:
```bash
npm start
```
Navigate to **http://localhost:3000**

Run the tests:
--------------
To run Jasmine tests, first bundle the tests script:
```bash
./node_modules/.bin/gulp webpack:tests
```
Then
```bash
open ./test/index.html
```

Behave/Selenium feature tests:
```bash
behave
```

