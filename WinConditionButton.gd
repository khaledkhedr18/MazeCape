extends Interactable

@onready var win_timer = $WinTimer

func _on_interacted(body):
	$AudioStreamPlayer3D.play()	
	win_timer.start()
	


func _on_win_timer_timeout():
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		get_tree().change_scene_to_file("res://UI Screens/Scenes/game_over.tscn")
		$AudioStreamPlayer3D.play()
