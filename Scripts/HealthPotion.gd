extends Interactable


@export var charpath : NodePath
@onready var character := get_node(charpath)
@export var inventorypath : NodePath
@onready var inventory := get_node(inventorypath)
var HealthPotionResource = preload("res://Resources/HealthPotion.tres")

func _on_interacted(body):
	if $".".visible:
		inventory.Add(HealthPotionResource)
		inventory.reflowButtons()
		queue_free()



