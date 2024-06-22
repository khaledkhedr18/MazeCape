extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var lookat
var lastLookAtDirection : Vector3
func _ready():
	lookat = get_tree().get_nodes_in_group("CameraController")[0].get_node("LookAt")
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta):
	# Add the gravity.
	if Input.is_action_just_pressed("Inventory"):
		$"../Inventory".visible = !$"../Inventory".visible
		if $"../Inventory".visible:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_right", "ui_left", "ui_down", "ui_up")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		var lerpDirection = lerp(lastLookAtDirection, Vector3(lookat.global_position.x, global_position.y, lookat.global_position.z), .05)
		look_at(Vector3(lerpDirection.x, global_position.y, lerpDirection.z))
		lastLookAtDirection = lerpDirection
		
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	$AnimationTree.set("parameters/conditions/idle", direction == Vector3.ZERO && is_on_floor())
	$AnimationTree.set("parameters/conditions/moving", direction != Vector3.ZERO && is_on_floor())
	$AnimationTree.set("parameters/BlendSpace2D/blend_position", -input_dir)
	# $AnimationTree.set("parameters/conditions/straifLeft", input_dir.x == -1 && is_on_floor())
	# $AnimationTree.set("parameters/conditions/straifRight", input_dir.x == 1 && is_on_floor())
	# $AnimationTree.set("parameters/conditions/falling", !is_on_floor())
	# $AnimationTree.set("parameters/conditions/landed", is_on_floor())
	move_and_slide()
