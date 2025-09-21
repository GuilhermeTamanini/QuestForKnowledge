extends Node2D

@export var enemyScene = load("res://scenes/entities/enemy.tscn")
@export var configs: Array[EnemyConfig] = []
@export var spawnRadius: float = 200
@export var count: int = 3

func spawnEnemies(center: Vector2):
	for i in range(count):
		if configs.is_empty(): return

		var enemy = enemyScene.instantiate()

		var cfg: EnemyConfig = configs[randi() % configs.size()]

		add_child(enemy)
		enemy.setupFromConfig(cfg)

		var angle = randf() * TAU
		var offset = Vector2(cos(angle), sin(angle)) * spawnRadius
		enemy.global_position = center + offset

		add_child(enemy)
