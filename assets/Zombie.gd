extends CharacterBody3D
var player=null
var speed=0
const gravity=9.8
const attack_r=2.5
var target_anim="Run"
var health=50
signal zombie_hit
@onready var armature = $Armature
var SpeedPotion = ResourceLoader.load("res://assets/speed_potion.tscn")
var JumpPotion = ResourceLoader.load("res://assets/jump_potion.tscn")
var HealthPotion = ResourceLoader.load("res://assets/HealthPotion.tscn")
var Potions = [JumpPotion, SpeedPotion, HealthPotion]
@onready var a_p=$"../../MainChar/AnimationPlayer"
@export var player_path : NodePath
@onready var nav = $NavigationAgent3D
@onready var anim_z = $AnimationTree
@onready var anim_p = $AnimationPlayer
@onready var state_machine = anim_z.get("parameters/playback")
var rand_index = randi() % Potions.size()
var randpotion = Potions[rand_index]

func _ready():
	player=get_node(player_path)
func _process(delta):

	velocity=Vector3.ZERO
	nav.set_target_position(player.global_transform.origin)
	var next_nav_point=nav.get_next_path_position()
	velocity=(next_nav_point-global_transform.origin).normalized()*speed
	look_at(Vector3(player.global_position.x,global_position.y,player.global_position.z),Vector3.UP)
	var current_state = state_machine.get_current_node()
	if current_state!=target_anim:
		speed=0
	else:
		speed=4

	move_and_slide()

	anim_z.set("parameters/conditions/run",! _target_in_range())
	anim_z.set("parameters/conditions/attack",_target_in_range())
	anim_z.set("parameters/conditions/die",health<=0)


func _target_in_range():
	if player.Health > 0:
		return global_position.distance_to(player.global_position) < attack_r


func _hit_finished():

	if global_position.distance_to(player.global_position) < attack_r+1:
		var dir=global_position.direction_to(player.global_position)
		player.hit(dir)
		player.Health=player.Health-1
		if player.Health<=0:
			var loot = randpotion.instantiate()
			loot.position = position
			$".".add_child(loot)
			player.WALK_SPEED=0
			player.SPRINT_SPEED=0
			player.JUMP_VELOCITY=0
			a_p.play("died")


func _on_area_3d_body_part_hit(dam):
	health -= dam
	emit_signal("zombie_hit")
	if health <= 0:
		print("Zombie health is zero or less, dropping loot")
		var loot = randpotion.instantiate()
		loot.global_transform.origin = global_transform.origin
		get_tree().root.add_child(loot)
		print("Loot Dropped!")
		await get_tree().create_timer(2).timeout
		queue_free()
	
