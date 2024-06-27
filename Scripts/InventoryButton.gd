extends Button

var currentItem
var currentIcon
var currentLabel
var index

signal OnButtonClick(Index, item)

func _ready():
	currentIcon = $TextureRect
	currentLabel = $Label


func UpdateItem(item, index):
	self.index = index
	currentItem = item

	if currentItem == null:
		currentIcon.texture = null
		currentLabel.text = ""

	else:
		currentIcon.texture = item.Icon
		currentLabel.text = str(item.Quantity)



func _on_button_down():
	emit_signal("OnButtonClick", index, currentItem)
