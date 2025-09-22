extends Control

var characterManager: CharacterManager
var player: IPlayer
var selectedIndex: int = 0
var playerId: String

@onready var startButton: Button = $CenterContainer/StartButton
@onready var continueButton: Button = $CenterContainer/ContinueButton
@onready var quitButton: Button = $CenterContainer/QuitButton

func _ready():
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

	characterManager = CharacterManager.new()
	characterManager.loadPlayerClasses()

	startButton.pressed.connect(startNewGame)
	continueButton.pressed.connect(continuePressed)
	quitButton.pressed.connect(quitGame)

func startNewGame():
	GlobalHelper.changeSceneTo(GameEnums.SceneEnum.WORLD)

func continuePressed():
	GlobalHelper.changeSceneTo(GameEnums.SceneEnum.WORLD)

func quitGame():
	get_tree().quit()
