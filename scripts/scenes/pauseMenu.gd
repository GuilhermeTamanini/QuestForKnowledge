extends Control

@onready var continueButton = $CenterContainer/VBoxContainer/ContinueButton
@onready var quitButton = $CenterContainer/VBoxContainer/QuitButton

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	visible = false

	continueButton.pressed.connect(_onContinuePressed)
	quitButton.pressed.connect(_onQuitPressed)

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		_togglePause()

func _togglePause():
	get_tree().paused = not get_tree().paused
	visible = get_tree().paused

func _onContinuePressed():
	_togglePause()

func _onQuitPressed():
	get_tree().quit()
