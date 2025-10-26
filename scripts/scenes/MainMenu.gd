extends Control

@onready var continueButton: Button = $CenterContainer/ContinueButton
@onready var quitButton: Button = $CenterContainer/QuitButton

func _ready():
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

	continueButton.pressed.connect(_continuePressed)
	quitButton.pressed.connect(_quitGame)

func _continuePressed():
	GlobalHelper.changeSceneTo(GameEnums.SceneEnum.WORLD)

func _quitGame():
	get_tree().quit()
