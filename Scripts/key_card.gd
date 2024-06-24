extends Interactable
var inventory

var key_card_resource = preload("res://Resources/Keys.tres")


func _on_interacted(body):
	inventory = get_node("../Inventory")
	inventory.PickupItem(key_card_resource)
	inventory.reflowButtons()
	queue_free()
