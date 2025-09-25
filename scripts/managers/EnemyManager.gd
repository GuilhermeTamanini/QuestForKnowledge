### EnemyManager.gd. Manager to handle enemySpawning
extends Node

var enemies: Array[Dictionary] = []
var alreadyInstantiated: bool = false
var configs: Array[EnemyConfig]
const ENEMIES_CONFIG_PATH: String = "res://enemies/"
const MOBS_PER_MAP = 0
const BOOS_PER_MAP = 1
var enemyScene: PackedScene = load("%s" % GlobalHelper.SCENE_PATHS[GameEnums.SceneEnum.ENEMY])

func _ready() -> void:
	alreadyInstantiated = false
	_loadEnemiesConfigs()

func instantiateEnemies(parent: Node2D):
	if !alreadyInstantiated:
		_spawnEnemiesByMap(parent)
		alreadyInstantiated = true
		return

	_respawnMobsInMap(parent)

func removeEnemy(id: String):
	for i in range(enemies.size()):
		if enemies[i]["id"] == id:
			enemies.remove_at(i)
			break

	GlobalManager.currentEnemyId = ""
	GlobalHelper.goToWorld()

func getEnemyById(id: String) -> Dictionary:
	for e in enemies:
		if e["id"] == id:
			return e
	return {}

func canChallengeBoss() -> bool:
	for e in enemies:
		if e["config"].dangerLevel == GameEnums.DangerLevel.MOB:
			return false

	return true

### Load the enemies configs from res://enemies/
func _loadEnemiesConfigs() -> void:
	var dir := DirAccess.open(ENEMIES_CONFIG_PATH)

	dir.list_dir_begin()

	var fileName = dir.get_next()

	while fileName != "":
		if fileName.ends_with(".tres") and !dir.current_is_dir():
			var res: Resource = load(ENEMIES_CONFIG_PATH + "/" + fileName)

			if res and res.map == GlobalManager.currentMap:
				configs.append(res)

		fileName = dir.get_next()

	dir.list_dir_end()

func _respawnMobsInMap(parent: Node2D) -> void:
	for enemyData in enemies:
		var enemy: Enemy = enemyScene.instantiate() as Enemy
		var cfg: EnemyConfig = enemyData["config"]
		var position: Vector2 = enemyData["position"]
		var id: String = enemyData["id"]

		enemy.setupFromConfig(cfg)
		enemy.global_position = position
		enemy.id = id

		parent.add_child(enemy)

func _spawnEnemiesByMap(parent: Node2D) -> void:
	var positions: Array[Vector2] = _getEnemiesPositionByMap()
	var mobConfigs: Array[EnemyConfig] = configs.filter(func(cfg): return cfg.dangerLevel == GameEnums.DangerLevel.MOB)
	var bossConfig: Array[EnemyConfig] = configs.filter(func(cfg): return cfg.dangerLevel == GameEnums.DangerLevel.BOSS)

	for i in range(MOBS_PER_MAP):
		var enemy: Enemy = enemyScene.instantiate() as Enemy
		var cfg: EnemyConfig = mobConfigs[randi() % mobConfigs.size()]
		var position: Vector2 = positions.pop_front()
		var id: String = "enemy%d" % i
		var isBoss := false
		
		_appendEnemy(parent, enemy, cfg, id, position, isBoss)

	for i in range(BOOS_PER_MAP):
		var enemy: Enemy = enemyScene.instantiate() as Enemy
		var cfg: EnemyConfig = bossConfig[0]
		var position: Vector2 = positions.pop_front()
		var id: String = "boss%d" % i
		var isBoss := true
		
		_appendEnemy(parent, enemy, cfg, id, position, isBoss)

func _getEnemiesPositionByMap() -> Array[Vector2]:
	var positions: Array[Vector2] = []

	match GlobalManager.currentMap:
		GameEnums.MapEnum.MAP1:
			positions = [Vector2(1, 1), Vector2(50, 50), Vector2(100, 100), Vector2(150, 150), Vector2(200, 200)]
		GameEnums.MapEnum.MAP2:
			positions = [Vector2(1, 1), Vector2(50, 50), Vector2(100, 100), Vector2(150, 150)]
		GameEnums.MapEnum.MAP3:
			positions = [Vector2(1, 1), Vector2(50, 50), Vector2(100, 100), Vector2(150, 150)]
		GameEnums.MapEnum.MAP4:
			positions = [Vector2(1, 1), Vector2(50, 50), Vector2(100, 100), Vector2(150, 150)]

	return positions
	
func _appendEnemy(parent, enemy, cfg, id, position, isBoss):
	enemy.setupFromConfig(cfg)

	parent.add_child(enemy)

	_createEnemy(id, position, cfg, isBoss)

	enemy.global_position = position
	enemy.id = id

func _createEnemy(id: String, pos: Vector2, cfg: EnemyConfig, isBoss: bool):
	enemies.append({
		"id": id,
		"position": pos,
		"config": cfg,
		"health": cfg.health,
		"isBoss": isBoss
	})
