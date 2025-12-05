### GlobalHelper
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
	GameEnums.MapEnum.MAP1: "res://assets/sprites/maps/map1.png",
	GameEnums.MapEnum.MAP2: "res://assets/sprites/maps/map2.png",
	GameEnums.MapEnum.MAP3: "res://assets/sprites/maps/map3.png",
	GameEnums.MapEnum.MAP4: "res://assets/sprites/maps/map4.png"
}

func getCurrentMapSprite() -> String:
	return MAP_SPRITES[GlobalManager.currentMap]

func setCurrentMap() -> void:
	if !GlobalManager.bossKilled:
		return

	GlobalManager.bossKilled = false
	GlobalManager.currentMapVal = GlobalManager.currentMapVal + 1
	var allMaps = GameEnums.MapEnum.values()

	if GlobalManager.currentMapVal < allMaps.size():
		GlobalManager.currentMap = allMaps[GlobalManager.currentMapVal]

func changeSceneTo(scene: GameEnums.SceneEnum) -> void:
	get_tree().change_scene_to_file(SCENE_PATHS[scene])

func gameOver() -> void:
	changeSceneTo(GameEnums.SceneEnum.GAMEOVER)
	MusicManager.stopMusic()

func startCombat() -> void:
	changeSceneTo(GameEnums.SceneEnum.COMBAT)
	MusicManager.playMusic(GameEnums.MusicEnum.BATTLE)

func goToWorld() -> void: changeSceneTo(GameEnums.SceneEnum.WORLD)

func goToMenu() -> void: changeSceneTo(GameEnums.SceneEnum.MENU)

func endGame() -> void:
	MusicManager.stopMusic()
	clearManagers()
	changeSceneTo(GameEnums.SceneEnum.END)

func killBoss() -> void:
	GlobalManager.bossKilled = true
	GlobalManager.bossCounter -= 1
	EnemyManager.alreadyInstantiated = false

	if GlobalManager.bossCounter == 0:
		clearManagers()
		endGame()
	else:
		goToWorld()

func clearManagers() -> void:
	GlobalManager.currentEnemyId = ""
	GlobalManager.bossCounter = 4
	GlobalManager.bossKilled = false
	GlobalManager.currentMap = GameEnums.MapEnum.MAP1
	GlobalManager.currentPlayer = null
	GlobalManager.playerPosisionBeforeLastBattle = Vector2(400, 400)
	GlobalManager.gameQuestions = GlobalManager.defaultQuestions
	EnemyManager.alreadyInstantiated = false
	EnemyManager.enemies = []
