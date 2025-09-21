### SaveManager
### Handle the game saves - 
extends Node

var saves: Array = []

func _ready():
	refreshSaves()

func refreshSaves():
	saves.clear()
	var dir = DirAccess.open("user://")

	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()

		while file_name != "":
			if file_name.ends_with(".json"):
				saves.append(file_name)

			file_name = dir.get_next()

		dir.list_dir_end()

func getSaves() -> Array:
	return saves

func createSave(name: String, data: Dictionary):
	var file = FileAccess.open("user://%s.json" % name, FileAccess.WRITE)
	file.store_string(JSON.stringify(data))
	file.close()
	refreshSaves()

func loadSave(name: String) -> Dictionary:
	var file = FileAccess.open("user://%s.json" % name, FileAccess.READ)
	if not file:
		return {}

	var text = file.get_as_text()
	file.close()

	var parsed = JSON.parse_string(text)
	
	push_error("Dict: %s" % parsed)
	
	if parsed.error == OK:
		return parsed.result
	else:
		push_error("Error when reading JSON: %s" % parsed.error_string)
		return parsed
