extends Control

@onready var startButton: Button = $CenterContainer/StartButton
@onready var continueButton: Button = $CenterContainer/ContinueButton
@onready var quitButton: Button = $CenterContainer/QuitButton

func _ready():
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

	startButton.pressed.connect(_startNewGame)
	continueButton.pressed.connect(_continuePressed)
	quitButton.pressed.connect(_quitGame)

func _startNewGame():
	GlobalHelper.changeSceneTo(GameEnums.SceneEnum.WORLD)

func _continuePressed():
	GlobalHelper.changeSceneTo(GameEnums.SceneEnum.WORLD)

func _quitGame():
	get_tree().quit()
