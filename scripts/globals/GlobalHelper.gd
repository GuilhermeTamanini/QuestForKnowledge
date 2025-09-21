extends Node

var worldInitialized: bool = false

const SCENE_PATHS: Dictionary = {
	GameEnums.SceneEnum.MENU: "res://scenes/menu.tscn",
	GameEnums.SceneEnum.LOADMENU: "res://scenes/loadmenu.tscn",
	GameEnums.SceneEnum.COMBAT: "res://scenes/battle.tscn",
	GameEnums.SceneEnum.GAMEOVER: "res://scenes/gameover.tscn",
	GameEnums.SceneEnum.WORLD: "res://scenes/world.tscn"
}

func changeSceneTo(scene: GameEnums.SceneEnum) -> void:
	get_tree().change_scene_to_file(SCENE_PATHS[scene])

func gameOver() -> void:
	changeSceneTo(GameEnums.SceneEnum.GAMEOVER)

func startCombat() -> void:
	changeSceneTo(GameEnums.SceneEnum.COMBAT)
	
func goToWorld() -> void:
	changeSceneTo(GameEnums.SceneEnum.WORLD)
