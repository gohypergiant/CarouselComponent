# CarouselComponent Framer Module

[![license](https://img.shields.io/github/license/bpxl-labs/RemoteLayer.svg)](https://opensource.org/licenses/MIT)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](.github/CONTRIBUTING.md)
[![Maintenance](https://img.shields.io/maintenance/yes/2017.svg)]()

The CarouselComponent module allows you to generate a scrolling carousel of items in a variety of configurations.
	
<img src="https://cloud.githubusercontent.com/assets/935/26805354/28e65a5c-4a11-11e7-854a-3cf275d5ef58.gif" width="501" style="display: block; margin: auto" alt="CarouselComponent preview" />	

### Installation

#### Manual installation

Copy or save the `CarouselComponent` file into your project's `modules` folder.

### Adding It To Your Project

In your Framer project add the following:

```coffeescript
ControlPanelLayer = require "CarouselComponent"
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
	subcaptionFontSize: <number>
	subcaptionFontWeight: <number>
	subcaptionMargin: <number>
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
Specify `sideCaptions: true` to vertically align captions alongside cells rather than underneath. Specify `topAlignSideCaptions: true` to align side captions to the tops of their adjacent cells.

#### Using the wrap feature
If you specify `wrap: true`, the first item in the carousel will display on its own row as a `hero` item. This item can be controlled independently of the rest of the carousel. Secondary cells will be sized according to `smallItemWidth` and `smallItemHeight` rather than `itemWidth` and `itemHeight`.

#### Using icons
Icons can be displayed under each item's cell. Specify `icons: true` to enable this. Enabling icons prevents the use of side captions.

#### Using images
All images are assumed to live in the images directory and be numbered starting with zero. You may supply both a prefix and suffix. If your item images are located in an `items` directory within `images` and named:

```coffeescript
cell0.png
cell1.png
cell2.png
```

then your `imagePrefix` would be `"items/cell"` and your suffix would be `"png"`.

Icon assets work the same way.

Do not include the `images` directory in `imagePrefix` or `iconPrefix`.

#### Assigning margins
Margins are supplied in the same order as for CSS. `margins: [40, 10, 15, 5]` will provide a top margin of 40, a right margin of 10, a bottom margin of 15, and a left margin of 5. The first item is positioned according to the top margin; however the title and link are positioned relative to the first item using `titleMargin`.

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
The `CarouselComponent` contains a PageComponent which can be accessed with `row` Items and their components can be accessed with the `items` array. `heroItem` is available when wrap is set to true.

```coffeescript
print myCarousel.row.currentPage
print myCarousel.heroItem?.caption?.text
print myCarousel.items[0].textBlock
print myCarousel.items[0].cell
```

#### Known issues

`CarouselComponent` does not calculate its full height until it has finished populating its content. Don’t attempt `y: Align.center`. Instead, use `myCarousel.y = Align.center` following instantiation. 
