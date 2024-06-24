extends RayCast3D

@onready var prompt = $Prompt

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _physics_process(_delta):
	prompt.text = ""
	var collider = get_collider()
	if collider is Interactable:
		prompt.text = collider.get_prompt()

		if Input.is_action_just_pressed(collider.prompt_input):
			collider.interact(owner)
