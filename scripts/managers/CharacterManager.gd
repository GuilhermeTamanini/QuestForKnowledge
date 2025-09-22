### Just a idea
extends Resource

class_name CharacterManager

var availablePlayers: Array = []
var characterspath: String = "res://characters/"

func loadPlayerClasses() -> void:
	var dir = DirAccess.open(characterspath)

	dir.list_dir_begin()
	var file_name = dir.get_next()

	while file_name != "":
		if file_name.ends_with(".gd"):
			var scriptPath = characterspath + file_name
			var script = load(scriptPath)
			availablePlayers.append(script)

		file_name = dir.get_next()

	dir.list_dir_end()
