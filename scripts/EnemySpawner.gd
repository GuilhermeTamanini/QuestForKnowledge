extends Node2D

@export var enemy_scene = load("res://scenes/entities/enemy.tscn")
@export var configs: Array[EnemyConfig] = []
@export var spawn_radius: float = 200
@export var count: int = 3

func spawn_enemies_around(center: Vector2):
	for i in range(count):
		if configs.is_empty(): return

		var enemy = enemy_scene.instantiate()

		var cfg: EnemyConfig = configs[randi() % configs.size()]

		add_child(enemy)
		enemy.setup_from_config(cfg)


		var angle = randf() * TAU
		var offset = Vector2(cos(angle), sin(angle)) * spawn_radius
		enemy.global_position = center + offset

		add_child(enemy)
