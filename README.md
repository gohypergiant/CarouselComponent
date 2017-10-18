# CarouselComponent Framer Module

[![license](https://img.shields.io/github/license/bpxl-labs/RemoteLayer.svg)](https://opensource.org/licenses/MIT)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](.github/CONTRIBUTING.md)
[![Maintenance](https://img.shields.io/maintenance/yes/2017.svg)]()

<a href="https://open.framermodules.com/carouselcomponent"><img alt="Install with Framer Modules" src="https://www.framermodules.com/assets/badge@2x.png" width='160' height='40' /></a>

The CarouselComponent module allows you to generate a scrolling carousel of items in a variety of configurations.
	
<img src="https://cloud.githubusercontent.com/assets/935/26805354/28e65a5c-4a11-11e7-854a-3cf275d5ef58.gif" width="501" style="display: block; margin: auto" alt="CarouselComponent preview" />	

### Installation

#### NPM Installation

```javascript
$ cd /your/framer/project
$ npm i @blackpixel/framer-carouselcomponent
```

#### Manual installation

Copy or save the `CarouselComponent` file into your project's `modules` folder.

### Adding It to Your Project

In your Framer project, add the following:

```coffeescript
# If you manually installed
CarouselComponent = require "CarouselComponent"
# else
CarouselComponent = require "@blackpixel/framer-carouselcomponent"
```

### API

#### `new CarouselComponent`

Instantiates a new instance of CarouselComponent.

#### Available options

```coffeescript
myCarousel = new CarouselComponent
	# Item cells
	itemCount: <number>
	rounded: <boolean>
	itemMargin: <number>
	itemBorderRadius: <number>
	itemWidth: <number>
	itemHeight: <number>
	smallItemWidth: <number>
	smallItemHeight: <number>

	# Labels
	title: <string>
	link: <string>
	captions: <array of strings>
	subcaptions: <array of strings>

	# Layout
	margins: <array of numbers> ([topMargin, rightMargin, bottomMargin, leftMargin])
	wrap: <boolean>
	sideCaptions: <boolean>
	topAlignSideCaptions: <boolean>

	# Hero-specific controls
	heroCaptionAlign: <string> ("left" | "center" | "right")
	centerheroItem: <boolean>
	sideHeroCaption: <boolean>
	topAlignHeroCaption: <boolean>

	# Colors
	boxColor: <string> (hex or rgba)
	iconColor: <string> (hex or rgba)
	titleColor: <string> (hex or rgba)
	linkColor: <string> (hex or rgba)
	captionColor: <string> (hex or rgba)
	subcaptionColor: <string> (hex or rgba)

	# Typography
	fontFamily: <string>
	titleFontSize: <number>
	titleFontWeight: <number>
	titleMargin: <number>
	linkFontSize: <number>
	linkFontWeight: <number>
	captionFontSize: <number>
	captionFontWeight: <number>
	captionMargin: <number>
	captionMaxHeight: <number>
	subcaptionFontSize: <number>
	subcaptionFontWeight: <number>
	subcaptionMargin: <number>
	subcaptionMaxHeight: <number>
	titleAlign: <string> ("left" | "center" | "right")
	captionAlign: <string> ("left" | "center" | "right")

	# Icons
	icons: <boolean>
	iconBorderRadius: <number>
	iconSize: <number>
	iconMargin: <number>

	# Image assets
	imagePrefix: <string> ("images" directory assumed)
	imageSuffix: <string>
	iconPrefix: <string> ("images" directory assumed)
	iconSuffix: <string>

	# Actions
	itemActions: <array of actions>
	linkAction: <action>

	# View CarouselComponent frame
	debug: <boolean>

	# Other
	forceScrolling: <boolean>
```

#### Using side captions
Specify `sideCaptions: true` to vertically align captions alongside cells, rather than underneath. Specify `topAlignSideCaptions: true` to align side captions to the tops of their adjacent cells.

<img src="https://user-images.githubusercontent.com/935/26845002-db4c73bc-4aba-11e7-822c-a16a15f79d73.png" width="401" style="display: block; margin: auto" alt="Top-aligned side captions" />	

#### Using the wrap feature
If you specify `wrap: true`, the first item in the carousel will display on its own row as a hero item. This item can be controlled independently of the rest of the carousel. Secondary cells will be sized according to `smallItemWidth` and `smallItemHeight`, rather than `itemWidth` and `itemHeight`.

<img src="https://user-images.githubusercontent.com/935/26845003-db4eb334-4aba-11e7-8e7b-779b8e9d35ef.png" width="340" style="display: block; margin: auto" alt="Using wrap" />	

#### Text alignment

You may specify `"left"`, `"center"`, or `"right"` for both `titleAlign` and `captionAlign`. `heroCaptionAlign` is also available when using the `wrap` feature.

#### Using icons
Icons can be displayed under each item's cell. Specify `icons: true` to enable this. **Enabling icons prevents the use of side captions.**

<img src="https://user-images.githubusercontent.com/935/26845006-db51de10-4aba-11e7-9339-6576ce11e525.png" width="340" style="display: block; margin: auto" alt="Using wrap with icons" />	

#### Using images
All images are assumed to live in the images directory and be numbered starting with zero. You may supply a prefix and suffix. If your item images are located in an `items` directory within `images` and named:

```coffeescript
cell0.png
cell1.png
cell2.png
```

then your `imagePrefix` will be `"items/cell"` and your suffix would be `"png"`.

Icon assets work the same way.

Do not include the `images` directory in `imagePrefix` or `iconPrefix`.

#### Assigning margins
Margins are supplied in the same order as they are for CSS. `margins: [40, 10, 15, 5]` will provide a top margin of 40, a right margin of 10, a bottom margin of 15, and a left margin of 5. The first item is positioned according to the top margin; however the title and link are positioned relative to the first item using `titleMargin`.

<img src="https://user-images.githubusercontent.com/935/26845005-db5045dc-4aba-11e7-9026-c2263dfc55af.png" width="656" style="display: block; margin: auto" alt="Margins" />	

#### Maximum caption heights

You may enforce text truncation by supplying `captionMaxHeight` and `subcaptionMaxHeight`. The threshold that triggers truncation will depend on font size.

<img src="https://user-images.githubusercontent.com/935/26845004-db4fdd90-4aba-11e7-862d-ff65403edea9.png" width="340" style="display: block; margin: auto" alt="Caption heights" />	

#### Scrolling
The CarouselComponent will attempt to provide scrolling only when its content extends beyond the visible area. To enforce scrolling regardless, specify `forceScrolling: true`.

#### Assigning actions
The link button in the upper right of the carousel can be given an action, as can individual item cells. The link will only appear if you supply a string with `link: <string>` and the CarouselComponent includes at least two items. Item actions should be arranged in a comma-separated array, one action per line.

```coffeescript
linkAction: -> print "link"
itemActions: [
	-> print "1",
	-> print "second",
	-> print "item the third"
]
```

#### Referring to parts of the CarouselComponent
The `CarouselComponent` contains a PageComponent that can be accessed with `row`. Items and their components can be accessed with the `items` array. `heroItem` is available when wrap is set to true.

```coffeescript
print myCarousel.row.currentPage
print myCarousel.heroItem?.caption?.text
print myCarousel.items[0].textBlock
print myCarousel.items[0].cell
```

### Example project
[Download](https://minhaskamal.github.io/DownGit/#/home?url=https://github.com/bpxl-labs/CarouselComponent/tree/master/example.framer) the example to try it for yourself.

### Known issues

`CarouselComponent` does not calculate its full height until it has finished populating its content. Don’t attempt `y: Align.center`. Instead, use `myCarousel.y = Align.center` following instantiation. 

---

Website: [blackpixel.com](https://blackpixel.com) &nbsp;&middot;&nbsp;
GitHub: [@bpxl-labs](https://github.com/bpxl-labs/) &nbsp;&middot;&nbsp;
Twitter: [@blackpixel](https://twitter.com/blackpixel) &nbsp;&middot;&nbsp;
Medium: [@bpxl-craft](https://medium.com/bpxl-craft)
