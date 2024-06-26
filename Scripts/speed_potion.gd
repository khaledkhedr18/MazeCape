extends Interactable

@export var charpath : NodePath
@onready var character := get_node(charpath)
var inventorypath = "/root/Main_Level/Inventory"
@onready var inventory := get_node(inventorypath)
var SpeedPotionResource = preload("res://Resources/SpeedPotion.tres")

func _on_interacted(body):
	if $".".visible:
		inventory.Add(SpeedPotionResource)
		inventory.reflowButtons()
		queue_free()



func _on_used():
	character.use_jump_potion()
