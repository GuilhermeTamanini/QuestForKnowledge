extends Control

@onready var continueButton: Button = $CenterContainer/ContinueButton
@onready var formButton: Button = $CenterContainer/FormButton
@onready var quitButton: Button = $CenterContainer/QuitButton
@onready var msgLabel: Label = $CenterContainer/MsgLabel

func _ready():
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

	formButton.pressed.connect(_formButtonPressed)
	continueButton.pressed.connect(_continuePressed)
	quitButton.pressed.connect(_quitGame)

func _formButtonPressed() -> void:
	DisplayServer.clipboard_set("https://docs.google.com/forms/d/e/1FAIpQLSfb5lI6eJ8OgCcg2Ll-5qsIyBJ7iPpAZtPCOiOeawrCMzrgaQ/viewform?usp=publish-editor")
	msgLabel.text = "Link copiado para a área de transferência!"

func _continuePressed():
	GlobalHelper.changeSceneTo(GameEnums.SceneEnum.WORLD)

func _quitGame():
	get_tree().quit()
