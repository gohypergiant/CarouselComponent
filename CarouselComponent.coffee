###
	# USING THE CAROUSELCOMPONENT

	# Require the module
	CarouselComponent = require "CarouselComponent"

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

	# Using side captions
	Specify sideCaptions: true to vertically align captions alongside cells rather than underneath. Specify topAlignSideCaptions: true to align side captions to the tops of their adjacent cells.

	# Using the wrap feature
	# If you specify wrap: true, the first item in the carousel will display on its own row as a "hero" item. This item can be controlled independently of the rest of the carousel. Secondary cells will be sized according to smallItemWidth and smallItemHeight rather than itemWidth and itemHeight.

	# Using icons
	# Icons can be displayed under each item's cell. Specify icons: true to enable this. Enabling icons prevents the use of side captions.

	# Using images
	# All images are assumed to live in the images directory and be numbered starting with zero. You may supply both a prefix and suffix. If your item images are located in an "items" directory within "images" and named:

	cell0.png
	cell1.png
	cell2.png

	# then your imagePrefix would be "items/cell" and your suffix would be "png".

	# Icon assets work the same way.

	# Do not include the images directory in imagePrefix or iconPrefix.

	# Assigning margins
	# Margins are supplied in the same order as for CSS. margins: [40, 10, 15, 5] will provide a top margin of 40, a right margin of 10, a bottom margin of 15 and a left margin of 5. The first item is positioned according to the top margin; however the title and link are positioned relative to the first item using titleMargin.

	# Scrolling
	# The CarouselComponent will attempt to provide scrolling only when its content extends beyond the visible area. To enforce scrolling regardless, specify forceScrolling: true.

	# Assigning actions
	# The link button in the upper right of the carousel can be given an action, as can individual item cells. The link will only appear if you supply a string with link: <string> and the CarouselComponent includes at least two items. Item actions should be arranged in a comma-separated array, one action per line.
	linkAction: -> print "link"
	itemActions: [
		-> print "1",
		-> print "second",
		-> print "item the third"
	]

	# Referring to parts of the CarouselComponent
	# The CarouselComponent contains a PageComponent which can be accessed with .row. Items and their components can be accessed with the .items array. .heroItem is available when wrap is set to true.
	print myCarousel.row.currentPage
	print myCarousel.heroItem?.caption?.text
	print myCarousel.items[0].textBlock
	print myCarousel.items[0].cell
###

defaults =
	itemCount: 3

	debug: false
	rounded: false
	wrap: false
	sideCaptions: false
	captionAlign: "left"
	titleAlign: "left"
	topAlignSideCaptions: false
	centerheroItem: false
	heroCaptionAlign: "left"
	sideHeroCaption: false
	topAlignHeroCaption: true
	icons: false
	clip: true
	forceScrolling: false
	margins: [40,0,0,0]
	itemMargin: 12
	itemBorderRadius: 10
	itemWidth: 160
	itemHeight: 120
	smallItemWidth: 80
	smallItemHeight: 60
	titleFontSize: 20
	titleFontWeight: 800
	titleMargin: 4
	linkFontSize: 16
	linkFontWeight: 400
	captionFontSize: 18
	captionFontWeight: 400
	captionMaxHeight: 100
	subcaptionFontSize: 16
	subcaptionFontWeight: 400
	subcaptionMaxHeight: 100

	iconBorderRadius: 10
	iconSize: 40
	iconMargin: 8

	captionMargin: 10
	subcaptionMargin: 0

	backgroundColor: "clear"
	boxColor: "orange"
	iconColor: ""
	titleColor: "orange"
	linkColor: ""
	captionColor: ""
	subcaptionColor: ""

	fontFamily: ""
	title: "Carousel Title"
	link: ""
	imagePrefix: ""
	imageSuffix: "png"
	iconPrefix: ""
	iconSuffix: "png"
	captions: []
	subcaptions: []
	itemActions: []
	linkAction: () ->

rounded =
	itemWidth: 120
	itemHeight: 120
	smallItemWidth: 60
	smallItemHeight: 60

# CarouselComponent class
class CarouselComponent extends Layer
	constructor: (@options={}) ->
		@options = _.assign({}, defaults, @options)
		if @options.rounded == true
			@options = _.assign({}, rounded, @options)
		super @options

		noop = () ->
		@.items = []

		# break out margins
		[topMargin, rightMargin, bottomMargin, leftMargin] = @options.margins

		# container view
		@.clip = @options.clip
		@.backgroundColor = @options.backgroundColor
		@.width = @options.width or Screen.width
		@.x = @options.x
		if @options.debug == true
			@.backgroundColor = "rgba(254, 163, 32, 0.25)"

		# icon setting incompatibile with side captions for now
		if @options.icons == true
			@options.sideCaptions = "none"

		# offset is used to pass over 1st cell in a wrapping situation
		offset = if @options.wrap == true then 1 else 0

		# hidden margin helps contentFrame() perform correctly
		margin = new Layer
			parent: @
			name: "margin"
			width: @.width
			height: 1
			visible: false

		@.margin = margin

		# carousel title
		title = new TextLayer
			parent: @
			x: leftMargin
			text: @options.title
			fontSize: @options.titleFontSize
			color: @options.titleColor
			textAlign: @options.titleAlign
			fontWeight: @options.titleFontWeight
			width: @.width - leftMargin - rightMargin

		@.title = title

		title.maxY = topMargin - @options.titleMargin
		if @options.fontFamily != "" then title.fontFamily = @options.fontFamily

		# carousel link
		if @options.link != ""
			link = new TextLayer
				parent: @
				text: @options.link
				fontSize: @options.titleFontSize
				originX: 1
				originY: 1
				autoSize: true
				autoSizeHeight: true
				color: @options.linkColor or @options.captionColor or @options.titleColor
				textAlign: "right"
				fontWeight: @options.linkFontWeight
				x: Align.right(-rightMargin)
				y: title.y
				scale: @options.linkFontSize/@options.titleFontSize

			@.link = link

			if @options.fontFamily != "" then link.fontFamily = @options.fontFamily
			if @options.linkAction != noop
				link.onClick =>
					@options.linkAction()

		# item creation
		createItem = (i = 0, parent = null, hero = false) =>
			if hero == false and @options.wrap == true
				indexOffset = 1
				itemWidth = @options.smallItemWidth
				itemHeight = @options.smallItemHeight
			else
				indexOffset = 0
				itemWidth = @options.itemWidth
				itemHeight = @options.itemHeight
			item = new Layer
				name: "item" + (i + indexOffset)
				width: itemWidth
				height: itemHeight
				backgroundColor: "clear"
				clip: false
			if parent instanceof PageComponent
				parent.addPage(item)
			else
				item.parent = parent

			# item cell
			block = new Layer
				parent: item
				name: "block" + (i + indexOffset)
				width: itemWidth
				height: itemHeight
				backgroundColor: @options.boxColor
				borderRadius: @options.itemBorderRadius
				image: "images/" + @options.imagePrefix + (i + indexOffset) + "." + @options.imageSuffix
				style:
					"background-position" : "center center"
					"background-size" : "cover"

			item.cell = block

			# assign item action
			if @options.itemActions[i + indexOffset] != noop and @options.itemActions[i + indexOffset] != undefined
				item.onClick =>
					return if parent.parent.isDragging
					@options.itemActions[i + indexOffset]()

			# item icon
			if @options.icons == true
				icon = new Layer
					parent: item
					name: "icon" + (i + indexOffset)
					width: @options.iconSize
					height: @options.iconSize
					backgroundColor: @options.iconColor or @options.boxColor
					borderRadius: @options.iconBorderRadius
					y: block.maxY + @options.iconMargin
					image: "images/" + @options.iconPrefix + (i + indexOffset) + "." + @options.iconSuffix
					style:
						"background-position" : "center center"
						"background-size" : "cover"

				item.icon = icon

			# item text container, enables vertical alignment
			textBlock = new Layer
				parent: item
				name: "textBlock" + (i + indexOffset)
				width: if @options.icons == true then itemWidth - @options.iconSize - @options.iconMargin else itemWidth
				height: item.height
				backgroundColor: "clear"
				x: @captionAlignHorizontal((if @options.icons == true then @options.iconSize else block.width), hero)

			item.textBlock = textBlock

			# item caption
			caption = new TextLayer
				parent: textBlock
				name: "caption" + (i + indexOffset)
				width: textBlock.width
				color: @options.captionColor or @options.titleColor
				text: @options.captions[(i + indexOffset)] or ""
				textAlign: "left"
				fontWeight: @options.captionFontWeight
				fontSize: @options.captionFontSize

			item.caption = caption

			if caption.height > @options.captionMaxHeight
				caption.height = @options.captionMaxHeight
				caption.truncate = true

			if @options.fontFamily != "" then caption.fontFamily = @options.fontFamily

			# item subcaption
			if @options.subcaptions != []
				subcaption = new TextLayer
					parent: textBlock
					name: "subcaption" + (i + indexOffset)
					width: textBlock.width
					color: @options.subcaptionColor or @options.captionColor or @options.titleColor
					text: @options.subcaptions[(i + indexOffset)] or ""
					textAlign: "left"
					fontWeight: @options.subcaptionFontWeight
					fontSize: @options.subcaptionFontSize
					letterSpacing: -0.6
					y: caption.maxY + @options.subcaptionMargin

				item.subcaption = subcaption

				if subcaption.height > @options.subcaptionMaxHeight
					subcaption.height = @options.subcaptionMaxHeight
					subcaption.truncate = true

				if @options.fontFamily != "" then subcaption.fontFamily = @options.fontFamily

			# round item block if specified
			if @options.rounded == true
				block.borderRadius = Math.max(@options.itemWidth, @options.itemHeight)/2

			# text alignment
			caption.textAlign = @options.captionAlign
			subcaption?.textAlign = @options.captionAlign

			# add to array
			@.items.push(item)

			# size text block height to match content
			textBlock.height = textBlock.contentFrame().height
			textBlock.y = @captionAlignVertical(block.height, hero)

			# size item height to match content
			item.height = item.contentFrame().height
			item.width = item.contentFrame().width

			# carousel marigns are applied after page is in place
			if @.items.indexOf(item) > offset
				item.x = item.x + @options.itemMargin

		# create hero cell
		if @options.wrap == true
			heroItemContainer = new Layer
				parent: @
				name: "heroItemContainer"
				y: topMargin
				x: if @options.centerheroItem == true then Align.center else leftMargin
				backgroundColor: "clear"
			createItem(0, heroItemContainer, true)
			heroItemContainer.height = heroItemContainer.contentFrame().height
			heroItemContainer.width = heroItemContainer.contentFrame().width

			@.heroItem = heroItemContainer.children[0]
			@.heroItem.name = "heroItem"

			# hero text alignment
			@.heroItem.caption.textAlign = @options.heroCaptionAlign
			@.heroItem.subcaption?.textAlign = @options.heroCaptionAlign

		# create the carousel
		row = new PageComponent
			parent: @
			name: "row"
			y: if @options.wrap == true then heroItemContainer.maxY + @options.itemMargin else topMargin
			scrollVertical: false
			scrollHorizontal: true
			velocityThreshold: 0.1
			clip: false
			originX: 0
			contentInset:
				top: 0
				right: rightMargin
				bottom: 0
				left: leftMargin

		@.row = row

		# account for a "short" carousel
		if @options.itemCount < 2
			row.scrollHorizontal = false
			link?.destroy()

		# actually populate the carousel row with its items
		for i in [0...@options.itemCount - offset]
			createItem(i, row, false)

		# prevent overscroll
		row.onSwipeLeft =>
			if @options.forceScrolling != true and @checkIfNeedsScrolling(row)
				maxPage = @options.itemCount - Math.floor(@.width / (@options.itemWidth + @options.itemMargin)) - offset
				if row.content.maxX < @.maxX
					row.snapToPage(@.items[maxPage])

		# adjust carousel to match content
		row.width = row.content.children[0]?.width
		row.content.width = row.content.contentFrame().width
		row.content.height = row.content.contentFrame().height
		row.height = row.contentFrame().height
		row.content.clip = false
		row.scrollHorizontal = @checkIfNeedsScrolling(row)
		@.height = @.contentFrame().height + bottomMargin

	checkIfNeedsScrolling: (layer = null) ->
		if @options.forceScrolling == true
			needsScrolling = true
		else if layer.content?.contentFrame().width > @.width
			needsScrolling = true
		else
			needsScrolling = false
		return needsScrolling

	captionAlignVertical: (itemHeight = 0, hero = false) ->
		align = itemHeight + @options.captionMargin
		if @options.icons == true
			align = itemHeight + @options.iconMargin
		else if hero == true
			if @options.sideHeroCaption == true
				if @options.topAlignHeroCaption == true
					align = Align.top
				else
					align = Align.center
		else if @options.sideCaptions == true
			if @options.topAlignCaptions == true
				align = Align.top
			else
				align = Align.center
		return align

	captionAlignHorizontal: (itemWidth = 0, hero = false) ->
		align = Align.left
		if @options.icons == true
			align = itemWidth + @options.iconMargin
		else if hero == true
			if @options.sideHeroCaption == true
				align = itemWidth + @options.captionMargin
		else if @options.sideCaptions == true
			align = itemWidth + @options.captionMargin
		else if @options.sideCaptions == true
			align = itemWidth + @options.captionMargin
		return align
module.exports = CarouselComponent
