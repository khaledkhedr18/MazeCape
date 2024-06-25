extends Interactable


@export var charpath : NodePath
@onready var character := get_node(charpath)
@export var inventorypath : NodePath
@onready var inventory := get_node(inventorypath)
var JumpPotionResource = preload("res://Resources/JumpPotion.tres")

func _on_interacted(body):
	if $".".visible:
		inventory.PickupItem(JumpPotionResource)
		inventory.reflowButtons()
		queue_free()



func _on_used():
	character.use_jump_potion()
