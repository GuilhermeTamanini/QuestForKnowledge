extends Control

@onready var menuButton: Button = $VBoxContainer/HBoxContainer/MenuButton
@onready var quitButton: Button = $VBoxContainer/HBoxContainer/ExitButton

func _ready() -> void:
	anchor_left = 0
	anchor_top = 0
	anchor_right = 1
	anchor_bottom = 1

	menuButton.pressed.connect(_onMenuPressed)
	quitButton.pressed.connect(_onQuitPressed)

func _onMenuPressed() -> void:
	GlobalHelper.goToMenu()

func _onQuitPressed() -> void:
	get_tree().quit()
