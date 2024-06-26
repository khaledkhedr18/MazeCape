extends Resource


@export var ID : int
@export var Name : String
@export var ResourcePath : String
@export var Icon : Texture2D
@export var Quantity : int
@export var StackSize : int
@export var IsStackable : bool
@export var Usable : bool


func UseItem(character):
	match ID:
		3: # Health Potion ID
			if character.Health < 100:
				character.Health += 20
			
			if character.Health > 100:
				character.Health = 100

		4:
			character.use_jump_potion()

		5:
			character.use_speed_potion()
			
		_:
			print("Nope!")

