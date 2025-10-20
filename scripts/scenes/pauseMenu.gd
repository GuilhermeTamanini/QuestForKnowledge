extends Control

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	visible = false
	get_tree().paused = false

func _togglePause():
	get_tree().paused = not get_tree().paused
	visible = get_tree().paused

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		_togglePause()
