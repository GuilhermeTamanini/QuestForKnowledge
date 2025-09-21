extends Node2D

var battle_started := false
@export var enemyScene: PackedScene = load("res://scenes/entities/enemy.tscn")
@export var configs: Array[EnemyConfig] = []
@export var spawnRadius: float = 200
@export var count: int = 3

func _ready() -> void:
	var player_scene = load("res://scenes/entities/player.tscn")
	var player: IPlayer = player_scene.instantiate()
	var characterCfg: CharacterConfig = load("res://characters/Test.tres")
	player.setupFromConfig(characterCfg)
	add_child(player)
	player.global_position = Vector2(300, 300)

	GlobalManager.currentPlayer = player

	var camera = Camera2D.new()
	player.add_child(camera)
	camera.position = Vector2.ZERO
	camera.make_current()
	camera.position_smoothing_enabled = true
	camera.position_smoothing_speed = 5.0
	camera.zoom = Vector2(0.5, 0.5)

	if !GlobalHelper.worldInitialized:
		return
		
	spawnEnemies(player)
	GlobalHelper.worldInitialized = true

func spawnEnemies(player: IPlayer) -> void:
	if configs.is_empty(): 
		return

	for i in range(count):
		var enemy = enemyScene.instantiate() as Enemy
		var cfg: EnemyConfig = configs[randi() % configs.size()]
		enemy.setupFromConfig(cfg)

		var angle = randf() * TAU
		var offset = Vector2(cos(angle), sin(angle)) * spawnRadius
		enemy.global_position = player.global_position + offset

		add_child(enemy)
