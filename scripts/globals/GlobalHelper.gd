extends Node

var worldInitialized: bool = false

const SCENE_PATHS: Dictionary = {
	GameEnums.SceneEnum.MENU: "res://scenes/menu.tscn",
	GameEnums.SceneEnum.LOADMENU: "res://scenes/loadmenu.tscn",
	GameEnums.SceneEnum.COMBAT: "res://scenes/battle.tscn",
	GameEnums.SceneEnum.GAMEOVER: "res://scenes/gameover.tscn",
	GameEnums.SceneEnum.WORLD: "res://scenes/world.tscn",
	GameEnums.SceneEnum.ENEMY: "res://scenes/entities/enemy.tscn",
	GameEnums.SceneEnum.END: "res://scenes/endgame.tscn"
}

const MAP_SPRITES: Dictionary = {
	GameEnums.MapEnum.MAP1: "res://assets/sprites/map1.png",
	GameEnums.MapEnum.MAP2: "res://assets/sprites/map2.jpg",
	GameEnums.MapEnum.MAP3: "res://assets/sprites/map3.jpeg",
	GameEnums.MapEnum.MAP4: "res://assets/sprites/map4.png"
}

func getCurrentMapSprite() -> String:
	push_warning(MAP_SPRITES[GlobalManager.currentMap])
	push_warning("currentMap: %d" % GlobalManager.currentMap)
	return MAP_SPRITES[GlobalManager.currentMap]

func setCurrentMap() -> void:
	if !GlobalManager.bossKilled:
		return

	GlobalManager.bossKilled = false
	GlobalManager.currentMapVal += 1
	var all_maps = GameEnums.MapEnum.values()
	if GlobalManager.currentMapVal < all_maps.size():
		GlobalManager.currentMap = all_maps[GlobalManager.currentMapVal]

func changeSceneTo(scene: GameEnums.SceneEnum) -> void:
	get_tree().change_scene_to_file(SCENE_PATHS[scene])

func gameOver() -> void: changeSceneTo(GameEnums.SceneEnum.GAMEOVER)

func startCombat() -> void:
	changeSceneTo(GameEnums.SceneEnum.COMBAT)
	MusicManager.playMusic(GameEnums.MusicEnum.BATTLE)

func goToWorld() -> void: changeSceneTo(GameEnums.SceneEnum.WORLD)

func goToMenu() -> void: changeSceneTo(GameEnums.SceneEnum.MENU)

func endGame() -> void: changeSceneTo(GameEnums.SceneEnum.END)

func clearManagers() -> void:
	GlobalManager.currentEnemyId = ""
	GlobalManager.currentMap = GameEnums.MapEnum.MAP1
	GlobalManager.currentPlayer = null
	GlobalManager.playerSprite = null
	GlobalManager.playerPosisionBeforeLastBattle = Vector2(400, 400)
	EnemyManager.alreadyInstantiated = false
	EnemyManager.enemies = []
