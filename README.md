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
```bash
npm start
```
Navigate to http://localhost:3000

Run the tests:
Jasmine unit tests
```bash
gulp webpack:tests
open ./test/index.html
```

Behave/Selenium feature tests:
```bash
behave
```

