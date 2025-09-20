extends Control

var characterManager: CharacterManager
var player: IPlayer
var selectedIndex: int = 0
var playerId: String
var savedPlayers: Array = []

@onready var startButton: Button = $CenterContainer/StartButton
@onready var continueButton: Button = $CenterContainer/ContinueButton
@onready var quitButton: Button = $CenterContainer/QuitButton

func _ready():
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	
	startButton.text = "Novo jogo"
	continueButton.text = "Continuar"
	quitButton.text = "Sair do jogo"
	
	if SaveManager.getSaves().is_empty():
		continueButton.disabled = true
	
	$CenterContainer/TitleLabel.text = "Quest for Knowledge: the battle of wits!"
	$CenterContainer/NameContainer/NameLabel.text = "Qual seu nome?"
	
	characterManager = CharacterManager.new()
	characterManager.loadPlayerClasses()

	startButton.pressed.connect(startNewGame)
	continueButton.pressed.connect(continuePressed)
	quitButton.pressed.connect(quitGame)

	loadSavedPlayers()

func loadSavedPlayers():
	var dir = DirAccess.open("user://")

	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		savedPlayers.clear()

		while file_name != "":
			if file_name.ends_with("_inventory.json"):
				var name = file_name.replace("_inventory.json", "")
				savedPlayers.append(name)

			file_name = dir.get_next()

		dir.list_dir_end()

	if savedPlayers.size() > 0:
		continueButton.disabled = false
		var container = $CenterContainer/SavedPlayerList

		for n in savedPlayers:
			var btn = Button.new()
			btn.text = n
			btn.pressed.connect(func(nm=n): loadPlayer(nm))
			container.add_child(btn)
	else:
		continueButton.disabled = true

func startNewGame():
	var name = $CenterContainer/NameContainer/NameInput.text.strip_edges()

	if name == "":
		name = "Player"

	playerId = name.to_lower().replace(" ", "_")
	var filePath = "user://%s_inventory.json" % playerId

	if FileAccess.file_exists(filePath):
		$CenterContainer/ErrorLabel.text = "Name already exists. Choose another."
		return

	var file = FileAccess.open(filePath, FileAccess.WRITE)

	if file:
		file.store_string("{}")
		file.close()

	showCharacterSelection(name)

func continuePressed():
	GlobalHelper.changeSceneTo(GameEnums.SceneEnum.WORLD)

func loadPlayer(name: String):
	playerId = name
	var filePath = "user://%s_inventory.json" % playerId
	var file = FileAccess.open(filePath, FileAccess.READ)

	if file:
		var result = JSON.parse_string(file.get_as_text())

		if result.error == OK:
			var data = result.result
			var className = data.get("class", "Warrior")
			var playerScript = load("res://characters/%s.gd" % className.to_lower())
			player = playerScript.new(name)
			player.inventory = data.get("inventory", [])

		file.close()

	get_tree().change_scene_to_file("res://scenes/combat.tscn")

func showCharacterSelection(name: String):
	$CenterContainer/NameContainer.visible = false
	$CenterContainer/CharacterContainer.visible = true

	for i in range(characterManager.availablePlayers.size()):
		var btn = $CenterContainer/CharacterContainer.get_child(i)
		var playerName = characterManager.availablePlayers[i].get_class()
		btn.text = playerName
		btn.pressed.connect(func(idx=i): selectCharacter(idx, name))

func selectCharacter(idx: int, name: String):
	selectedIndex = idx
	var playerScript = characterManager.availablePlayers[selectedIndex]
	player = playerScript.new(name)

	var filePath = "user://%s_inventory.json" % playerId
	var file = FileAccess.open(filePath, FileAccess.WRITE)

	if file:
		var data = {
			"name": playerId,
			"class": playerScript.get_class(),
			"inventory": player.inventory
		}
		
		file.store_string(JSON.stringify(data))
		file.close()

	get_tree().change_scene_to_file("res://scenes/combat.tscn")

func quitGame():
	get_tree().quit()
