extends Control

@onready var tryAgainButton: Button = $"VBoxContainer/OptionsContainer/HBoxContainer/TryAgainButton"
@onready var goToMenuButton: Button = $"VBoxContainer/OptionsContainer/HBoxContainer/GoToMenuButton"

func _ready() -> void:
	tryAgainButton.pressed.connect(tryAgain)
	goToMenuButton.pressed.connect(goToMenu)

func tryAgain() -> void:
	GlobalHelper.changeSceneTo(GameEnums.SceneEnum.WORLD)
	
func goToMenu() -> void:
	GlobalHelper.changeSceneTo(GameEnums.SceneEnum.MENU)
