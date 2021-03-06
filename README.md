Shopping Cart with ReactJs
==========================

![ReactJS Shopping Cart App](app-screenshot.png)

This is a shopping cart app built with [ReactJS](http://facebook.github.io/react/). I used the [Flux](https://facebook.github.io/flux/) architecture with [Fluxxor](fluxxor.com).

Initially I started doing this task using AngularJS, but it was becoming difficult when I wanted to update state. In AngularJS, state is scoped to each component. Sharing this state between the different components is annoying to deal with. I would either emit a change and have the other component listen and do what's necessary. Or have component specific data attached to the global (root) scope and use that in other components. It feels ugly to do this and slightly messy. So I started all over again and used ReactJS.

For tests, I used Jasmine to to do the unit tests. For the feature tests, I used [Behave](https://pythonhosted.org/behave/index.html) because it has a nicer API. It allows me to write features tests in words and match steps to those to execute.

I used [ExpressJS](http://expressjs.com/) to serve the app on a server. It's lightweight and quick to setup. I also use it run the Behave feature tests. I could have executed a python subprocess to start the server when the behave tests begin, but I still want to preview the app by myself.

I used [Webpack](http://webpack.github.io/) because it bundles all my app's dependencies into one single file. I could have used Gulp to concatenate my JavaScript files, but Webpack detects dependencies automatically and bundles them together. I only used [Gulp](http://gulpjs.com/) to run the Webpack bundling commands or to watch the app and test directories to run the appropriate bundling commands.

Finally, I used [Bootstrap](getbootstrap.com) because it's quicker to assemble a responsive UI. If this was a real project, I would use Bourbon and Neat with SASS.

Discount vouchers
===============
- **COFFEE15** - £5 discount
- **RABBIT9** - £10 discount if order is above £50
- **FOOT15** - £15 discount if order is above £75 and at least one footware item is purchased

Code tour
=========
This app was built using the Flux architecture so the directory structure is organised under `/app`. The app is split into different parts under their appropriate directories. The main parts are Components, Actions and Stores. The Store contains the main logic that is responsible for dealing with data. It has various methods that respond to specific actions. The Actions has methods that are triggered by the view which dispatch actions for a store to respond to. The Components are the different elements of the application such as Header, Sidebar, Products list and Product item.

The Jasmine tests are under `/test` directory and the features tests are under `/features` directory. 

Requirements:
-------------
- Python 3
- NPM/Node
- ChromeWebDriver

Project setup:
-------------
I recommend using [Virtualenv](https://virtualenv.pypa.io/en/latest/) and [VirtualenvWrappper](https://virtualenvwrapper.readthedocs.org/en/latest/) to isolate the installation of python libraries from your computer's global scope. Once you have the requirements installed, run the following commands:
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

To run behave/selenium tests, you need to have the app already running in a separate terminal tab:
```bash
npm start
```
**NOTE: `chromedriver` path must be in your /usr/local/bin or in $PATH**

Then you run behave:
```bash
behave
```

