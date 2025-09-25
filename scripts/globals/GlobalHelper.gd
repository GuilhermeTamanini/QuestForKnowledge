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

func changeSceneTo(scene: GameEnums.SceneEnum) -> void:
	get_tree().change_scene_to_file(SCENE_PATHS[scene])

func gameOver() -> void: changeSceneTo(GameEnums.SceneEnum.GAMEOVER)

func startCombat() -> void: changeSceneTo(GameEnums.SceneEnum.COMBAT)

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
	
