extends Control

@onready var savesList = $CenterContainer/SaveContainer/SaveList
@onready var backButton = $CenterContainer/BackButton
@onready var title = $CenterContainer/Title

func _ready():
	backButton.pressed.connect(onBackPressed)
	savesList.size_flags_horizontal = Control.SIZE_FILL | Control.SIZE_EXPAND
	savesList.size_flags_vertical = Control.SIZE_FILL | Control.SIZE_EXPAND
	savesList.item_activated.connect(func(index):
		var save_name = savesList.get_item_text(index) + "_inventory.json"
		loadSave(save_name)
	)
	populateSaves()

func populateSaves():
	savesList.clear()
	var saves = SaveManager.getSaves()
	for save in saves:
		var displayName = save.replace("_inventory.json", "")
		savesList.add_item(displayName)

func onBackPressed():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

func loadSave(file_name: String):
	var data = SaveManager.loadSave(file_name.replace(".json", ""))
	get_tree().change_scene_to_file("res://scenes/CharacterSelect.tscn")

func getSaves() -> Array:
	var dir = DirAccess.open("user://")
	var saves = []

	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()

		while file_name != "":
			if file_name.ends_with(".json"):
				saves.append(file_name)

			file_name = dir.get_next()

		dir.list_dir_end()

	return saves
