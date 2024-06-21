extends CharacterBody3D
var look_rot:Vector2
var speed=0
const WALK_SPEED = 5.0
const SPRINT_SPEED=10.0
const JUMP_VELOCITY = 4.5
const sensitivity =0.5
var min_a=-50
var max_a=60
const bob_freq=2.0
const bob_amp =0.08
var t_bob =0.0
const base_fov=75
const fov_change=1.5
var velocity_clamped=clamp(velocity.length(),0.5,SPRINT_SPEED*2)
var target_fov=base_fov+fov_change*velocity_clamped
@onready var anim_r=$AnimationPlayer

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var head =$head
@onready var cam =$head/Camera3D


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _input(event):
	if event is InputEventMouseMotion:
		look_rot.y-=(event.relative.x*sensitivity)
		look_rot.x+=(event.relative.y*sensitivity)
		look_rot.x=clamp(look_rot.x,min_a,max_a)
		
		
		
	


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("right", "left", "down", "up")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed 
	
			
			
			
		else:
			velocity.x=lerp(velocity.x,direction.x*speed,delta *7)
			velocity.z=lerp(velocity.z,direction.z*speed,delta *7)
		
	else:
		velocity.x=lerp(velocity.x,direction.x*speed,delta *2)
		velocity.z=lerp(velocity.z,direction.z*speed,delta *2)
		
		
		
	
		
	t_bob+=delta *velocity.length() * float(is_on_floor())
	cam.transform.origin=_headbob(t_bob)
	if Input.is_action_pressed("sprint"):
		speed=SPRINT_SPEED
	else:
		speed=WALK_SPEED
	cam.fov=lerp(cam.fov,target_fov,delta*8)
	
	
		
	
	$AnimationTree.set("parameters/conditions/idle", direction == Vector3.ZERO && is_on_floor())
	$AnimationTree.set("parameters/conditions/moving", direction != Vector3.ZERO && is_on_floor())
	$AnimationTree.set("parameters/conditions/firing", Input.is_action_pressed("fire"))
	
	#$AnimationTree.set("parameters/BlendSpace2D/blend_position", -input_dir)
	#$AnimationTree.set("parameters/conditions/straifLeft", input_dir.x == -1 && is_on_floor())
	#$AnimationTree.set("parameters/conditions/straifRight", input_dir.x == 1 && is_on_floor())
	#$AnimationTree.set("parameters/conditions/falling", !is_on_floor())
	#$AnimationTree.set("parameters/conditions/landed", is_on_floor())
	move_and_slide()
	head.rotation_degrees.x=look_rot.x
	rotation_degrees.y=look_rot.y
func _headbob(time) -> Vector3:
	var pos =Vector3.ZERO
	pos.y =sin(time*bob_freq)*bob_amp
	pos.x=cos(time*bob_freq/2)*bob_amp
	return pos

		
