#CoffeeMind
This repository contains the game mastermind written in coffeescript.

##To play the game

The game is contained in the **build** folder. Just open the *index.html* file in a browser.

---
- You are able to control the game with the following **keys:**
 	- left arrow (&#8592;): Go to the left square.
  	- right arrow (&#8594;): Go to the right square.
  	- up arrow (&#8593;): Next color.
  	- down arrow (&#8595;): Previous color.
  	- return (&#9166;): When every possible field has a color set, the next row is possible and you get hints for your selection.
	  - space (&#x02294;): Shows the solution.
- or with the **mouse**:
  	- left-click on square: next color
  	- click on reload symbol: Starts a new game.
  	- click on search symbol: (same as return (&#9166;))
  	- click on information symbol: Shows the solution (Same as  space (&#x02294;))
- on the right side there will be *two* different colors which will chow you how many colors are right (and on the right position)

## For further developments
The game is developed with **CoffeeScript** 

### Requirements


For developing the game you need **Node.js** (http://nodejs.org/)
After you installed *Node.js* you need the node package **Bower** (http://bower.io/). Just type 

	npm install -g bower

For installing the further requirements (listed in the **package.json** file, open your terminal and go to the repository root folder. Type

	npm install

The project uses **gulp** as task runner.

---
### Some legal stuff
Copyright (c) 2014, Andreas Augustin. All rights reserved.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#### External resources
- Node
- Bower
	- jQuery
- Cucumber/Gherkin
- Modernizr
- Jasmine-node
- JSDom
- run-sequence
- CoffeeScript
- Gulp
	- gulp-coffee
	- gulp-coffeelint
	- gulp-concat
	- gulp-cucumber
	- gulp-jasmine
	- gulp-notify
	- gulp-ruby-sass
	- gulp-uglify
	- gulp-util









