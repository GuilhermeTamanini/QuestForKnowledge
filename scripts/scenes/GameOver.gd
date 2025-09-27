extends Control

@onready var tryAgainButton: Button = $"VBoxContainer/OptionsContainer/HBoxContainer/TryAgainButton"
@onready var goToMenuButton: Button = $"VBoxContainer/OptionsContainer/HBoxContainer/GoToMenuButton"

func _ready() -> void:
	tryAgainButton.pressed.connect(_tryAgain)
	goToMenuButton.pressed.connect(_goToMenu)

func _tryAgain() -> void:
	GlobalHelper.changeSceneTo(GameEnums.SceneEnum.WORLD)

func _goToMenu() -> void:
	GlobalHelper.changeSceneTo(GameEnums.SceneEnum.MENU)
