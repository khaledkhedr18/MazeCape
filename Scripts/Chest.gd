extends Interactable

@export var Key : RigidBody3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_interacted(body):
	$AnimationPlayer.play("Unlocked")
	$Timer.start()

func _on_timer_timeout():
	queue_free()
	Key.visible = true
