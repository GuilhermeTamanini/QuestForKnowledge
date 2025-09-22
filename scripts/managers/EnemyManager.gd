extends Node

var enemiesData: Array[Dictionary] = []
var alreadyInstantiated: bool = false
var map: String
var configs: Array[EnemyConfig]
const ENEMIES_CONFIG_PATH: String = "res://enemies/"
var enemyScene: PackedScene = load("%s" % GlobalHelper.SCENE_PATHS[GameEnums.SceneEnum.ENEMY])

func _ready() -> void:
	_loadEnemiesConfigs()

func instantiateEnemies(parent: Node2D):
	if !alreadyInstantiated:
		_spawnEnemy(parent, Vector2(1, 1))

	for data in enemiesData:
		if data.has("node") and is_instance_valid(data.node):
			continue

		var enemy_node: Node2D = enemyScene.instantiate()
		enemy_node.setupFromConfig(data.config)
		enemy_node.global_position = data.position
		parent.add_child(enemy_node)

		data["node"] = enemy_node

	alreadyInstantiated = true

func _spawnEnemy(parentNode: Node2D, position: Vector2) -> void:
	if configs.is_empty():
		return

	for i in range(2):
		var enemy = enemyScene.instantiate() as Enemy
		var cfg: EnemyConfig = configs[randi() % configs.size()]
		enemy.setupFromConfig(cfg)

		parentNode.add_child(enemy)

		enemy.global_position = position

func _loadEnemiesConfigs() -> void:
	var dir := DirAccess.open(ENEMIES_CONFIG_PATH)

	if !dir:
		push_error("Não consegui abrir a pasta: %s" % ENEMIES_CONFIG_PATH)

	dir.list_dir_begin()

	var fileName = dir.get_next()

	while fileName != "":
		if fileName.ends_with(".tres") and !dir.current_is_dir():
			var res: Resource = load(ENEMIES_CONFIG_PATH + "/" + fileName)

			if res:
				configs.append(res)

		fileName = dir.get_next()

	dir.list_dir_end()
