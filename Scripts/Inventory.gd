extends Control

var gridContainer : GridContainer
var items : Array
var capacity = 20
var hoveredButton
var grabbedButton
var lastClickedMousePos : Vector2
var overTrash

# Called when the node enters the scene tree for the first time.
func _ready():
	
	gridContainer = $ScrollContainer/GridContainer
	populateButtons()
	pass # Replace with function body.


func _process(delta):
	pass


func _input(event):
	$MouseArea.position = get_tree().root.get_mouse_position()
	if hoveredButton != null:
		if Input.is_action_just_pressed("Throw"):
			grabbedButton = hoveredButton
			lastClickedMousePos = get_tree().root.get_mouse_position()

		if lastClickedMousePos.distance_to(get_tree().root.get_mouse_position()) > 2:
			if Input.is_action_pressed("Throw"):
				if grabbedButton == null:
					grabbedButton = hoveredButton
				$MouseArea/InventoryButton.show()
				$MouseArea/InventoryButton.UpdateItem(grabbedButton.currentItem, 0)

			if Input.is_action_just_released("Throw"):
				if overTrash:
					DeleteButton(grabbedButton)
				else:
					SwapButtons(grabbedButton, hoveredButton)
					$MouseArea/InventoryButton.hide()


	if Input.is_action_just_released("Throw") && $MouseArea/InventoryButton.visible:
		$MouseArea/InventoryButton.hide()
		if overTrash:
			DeleteButton(grabbedButton)
		grabbedButton = null


func DeleteButton(button):
	items.remove_at(items.find(button.currentItem))
	reflowButtons()


func populateButtons():
	for i in capacity:
		var packedScene = ResourceLoader.load("res://assets/InventoryButton.tscn")
		var itemButton = packedScene.instantiate()
		itemButton.connect("OnButtonClick", OnButtonClicked)
		$ScrollContainer/GridContainer.add_child(itemButton)
	

func SwapButtons(button1, button2):
	var button1Index = button1.get_index()
	var button2Index = button2.get_index()
	gridContainer.move_child(button1, button2Index)
	gridContainer.move_child(button2, button1Index)


func Add(item : Resource):
	var currentItem = item.duplicate()
	for i in items.size():
		if items[i].ID == currentItem.ID && items[i].Quantity != items[i].StackSize:
			if items[i].Quantity + currentItem.Quantity > items[i].StackSize:
				items[i].Quantity = currentItem.StackSize
				currentItem.Quantity = -(currentItem.Quantity - items[i].StackSize)
				updateButton(i)
			else:
				if items.size() <= 20:
					items[i].Quantity += currentItem.Quantity
					currentItem.Quantity = 0
					updateButton(i)
	if currentItem.Quantity > 0:
		if currentItem.Quantity < currentItem.StackSize:
			items.append(currentItem)
			if items.size() <= 20:
				updateButton(items.size() - 1)
			else:
				if items.size() <= 20:
					var tempItem = currentItem.duplicate()
					tempItem.Quantity = currentItem.StackSize
					items.append(tempItem)
					updateButton(items.size() - 1)
					currentItem.Quantity -= currentItem.StackSize
					Add(currentItem)


func Remove(item : Resource):
	var currentItem = item


	for i in items.size():
		if items[i].ID == currentItem.ID:
			if items[i].Quantity - currentItem.Quantity < 0:
				currentItem.Quantity -= items[i].Quantity
				items[i].Quantity = 0
				updateButton(i)
			else:
				items[i].Quantity -= currentItem.Quantity
				currentItem.Quantity = 0
				updateButton(i)

		if currentItem.Quantity <= 0:
			break

	var tempItems = items.duplicate()
	var offset = 0

	for i in tempItems.size():
		if items[i - offset].Quantity == 0:
			items.remove_at(i)
			offset += 1

	reflowButtons()


func reflowButtons():
	for i in capacity:
		updateButton(i)


func updateButton(index : int):
	if range(items.size()).has(index):
		gridContainer.get_child(index).UpdateItem(items[index], index)
	else:
		gridContainer.get_child(index).UpdateItem(null, index)


func OnButtonClicked(index, CurrentItem):
	if CurrentItem != null && Input.is_action_just_pressed("Throw"):
		CurrentItem.UseItem()
		CurrentItem.Quantity -= 1
		print(CurrentItem.Quantity)
		reflowButtons()
		if CurrentItem.Quantity == 0:
			Remove(CurrentItem)
	else:
		pass


func _on_button_button_down():
	Add(ResourceLoader.load("res://Item.tres"))


func _on_remove_item_button_down():
	Remove(ResourceLoader.load("res://Item.tres"))


func _on_mouse_area_entered(area):
	hoveredButton = area.get_parent()


func _on_mouse_area_exited(area):
	hoveredButton = null


func _on_trash_area_area_entered(area):
	overTrash = true
	pass # Replace with function body.


func _on_trash_area_area_exited(area):
	overTrash = false
	pass # Replace with function body.


func _on_remove_item_2_button_down():
	Remove(ResourceLoader.load("res://Item2.tres"))


func _on_add_item_2_button_down():
	Add(ResourceLoader.load("res://Item2.tres"))


func PickupItem(item: Resource):
	Add(item)


func UseItem(item: Resource):
	if item != null:
		item.UseItem()
		item.Quantity -= 1
		if item.Quantity == 0:
			Remove(item)
		reflowButtons()
