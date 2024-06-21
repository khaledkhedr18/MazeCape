extends Button

var currentItem
var currentIcon
var currentLabel
var index

signal OnButtonClick(Index, item)

# Called when the node enters the scene tree for the first time.
func _ready():
	currentIcon = $TextureRect
	currentLabel = $Label
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func UpdateItem(item, index):
	self.index = index
	currentItem = item

func _on_area_2d_area_entered(area):
	pass # Replace with function body.


func _on_area_2d_area_exited(area):
	pass # Replace with function body.


func _on_button_down():
	emit_signal("OnButtonClick", index, currentItem)
	pass # Replace with function body.
