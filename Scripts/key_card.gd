extends Interactable

var key_card_resource = preload("res://Resources/Keys.tres")
@export var inventorypath : NodePath
@onready var inventory := get_node(inventorypath)

func _on_interacted(body):
	inventory.PickupItem(key_card_resource)
	inventory.reflowButtons()
	queue_free()
