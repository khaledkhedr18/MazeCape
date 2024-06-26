extends Interactable

@export var charpath : NodePath
@onready var character := get_node(charpath)
@export var inventorypath : NodePath
@onready var inventory := get_node(inventorypath)
var SpeedPotionResource = preload("res://Resources/SpeedPotion.tres")

func _on_interacted(body):
	if $".".visible:
		inventory.PickupItem(SpeedPotionResource)
		inventory.reflowButtons()
		queue_free()



func _on_used():
	character.use_jump_potion()