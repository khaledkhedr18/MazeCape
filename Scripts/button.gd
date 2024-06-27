extends Interactable

@export var door : Node3D
@export var keycard_name : String = "Keycard"
var inventory : Control


func _ready():
	inventory = get_node("/root/Main_Level/Inventory")


func _on_interacted(body):
	if !inventory.has_item(keycard_name):
		$AudioStreamPlayer3D.play()
		door.toggle(body)
	else:
		print("Nope!!")
