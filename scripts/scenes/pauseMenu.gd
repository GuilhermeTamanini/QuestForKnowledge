extends Control

@onready var continueButton: Button = $CenterContainer/VBoxContainer/ContinueButton
@onready var menuButton: Button = $CenterContainer/VBoxContainer/MenuButton
@onready var quitButton: Button = $CenterContainer/VBoxContainer/QuitButton

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	visible = false

	continueButton.pressed.connect(_onContinuePressed)
	menuButton.pressed.connect(_onMenuPressed)
	quitButton.pressed.connect(_onQuitPressed)

func _unhandled_input(event) -> void:
	if event.is_action_pressed("ui_cancel"):
		_togglePause()

func _togglePause() -> void:
	get_tree().paused = not get_tree().paused
	visible = get_tree().paused

func _onMenuPressed() -> void:
	MusicManager.stopMusic()
	_togglePause()
	GlobalHelper.goToMenu()

func _onContinuePressed() -> void:
	_togglePause()

func _onQuitPressed() -> void:
	get_tree().quit()
