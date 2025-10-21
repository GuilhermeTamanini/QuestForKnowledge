extends Control

@onready var colorRect = $ColorRect
@onready var continueButton = $CenterContainer/VBoxContainer/ContinueButton
@onready var quitButton = $CenterContainer/VBoxContainer/QuitButton

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	visible = false

	continueButton.pressed.connect(onContinuePressed)
	quitButton.pressed.connect(onQuitPressed)

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		togglePause()

func togglePause():
	get_tree().paused = not get_tree().paused
	visible = get_tree().paused

func onContinuePressed():
	togglePause()

func onQuitPressed():
	get_tree().quit()
