extends Control

var gridContainer : GridContainer
var items : Array

# Called when the node enters the scene tree for the first time.
func _ready():
	gridContainer = $ScrollContainer/GridContainer
	populateButtons()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func populateButtons():
	for i in 20:
		var packedScene = ResourceLoader.load("res://assets/InventoryButton.tscn")
		var itemButton = packedScene.instantiate()
		itemButton.connect("OnButtonClick", OnButtonClicked)
		$ScrollContainer/GridContainer.add_child(itemButton)


func Add(item):
	items.append(item)


func updateButton(index : int):
	if range(items.size().has(i)):



func OnButtonClicked(index, CurrentItem):
	print("Clicked!!")



func _on_button_button_down():
	pass # Replace with function body.
