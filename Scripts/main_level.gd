extends Node3D
@onready var crosshair =$Control/crosshair
@onready var hit_rec=$Control/ColorRect
@onready var inv=$Inventory
@onready var crosshair2 =$Control/crosshair2


# Called when the node enters the scene tree for the first time.
func _ready():
	crosshair.position.x=get_viewport().size.x/2-64
	crosshair.position.y=get_viewport().size.y/2-64
	crosshair2.position.x=get_viewport().size.x/2-16
	crosshair2.position.y=get_viewport().size.y/2-16



# Called every frame. 'delta' is the elapsed time since the previous frame.



func _on_main_char_player_hit():
	hit_rec.visible=true
	await get_tree().create_timer(0.2).timeout
	hit_rec.visible=false

	
	
	


func _on_zombie_zombie_hit():
	crosshair2.visible=true
	await get_tree().create_timer(0.2).timeout
	crosshair2.visible=false
