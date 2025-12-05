extends Control

@onready var continueButton: Button = $CenterContainer/ContinueButton
@onready var formButton: Button = $CenterContainer/FormButton
@onready var quitButton: Button = $CenterContainer/QuitButton
@onready var msgLabel: Label = $CenterContainer/MsgLabel

@onready var link_popup = $LinkPopup
@onready var link_edit = $LinkPopup/VBoxContainer/LinkEdit
@onready var close_button = $LinkPopup/VBoxContainer/CloseButton

func _ready():
	close_button.pressed.connect(_close_popup)
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

	formButton.pressed.connect(_formButtonPressed)
	continueButton.pressed.connect(_continuePressed)
	quitButton.pressed.connect(_quitGame)

func _formButtonPressed() -> void:
	var link = "https://docs.google.com/forms/d/e/1FAIpQLSfb5lI6eJ8OgCcg2Ll-5qsIyBJ7iPpAZtPCOiOeawrCMzrgaQ/viewform?usp=publish-editor"

	JavaScriptBridge.eval("window.open('%s', '_blank');" % link)

	link_popup.set_size(Vector2(700, 200))
	link_edit.text = link
	link_popup.popup_centered()

	link_edit.grab_focus()
	link_edit.select_all()

func _close_popup():
	link_popup.hide()

func _continuePressed():
	GlobalHelper.changeSceneTo(GameEnums.SceneEnum.WORLD)

func _quitGame():
	get_tree().quit()
