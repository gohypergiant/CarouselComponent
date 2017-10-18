CarouselComponent = require "CarouselComponent"

############################################
# Example usage.
# For all features, please check the README.
############################################

myCarousel = new CarouselComponent
	title: "My Carousel"
	titleColor: "gray"
	itemCount: 4
	itemMargin: 10
	itemWidth: 160
	itemHeight: 100
	itemBorderRadius: 16
	captions: ["Item 1", "Item 2", "Item 3", "Item 4"]
for item, index in myCarousel.items
	item.cell.backgroundColor = new Color("hsl(#{200 + index * 10}, 95, 57)")
