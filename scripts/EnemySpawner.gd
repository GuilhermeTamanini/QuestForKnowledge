extends Node2D

var EnemyScene = preload("res://scenes/Enemy.tscn")

func spawn_enemy(config: EnemyConfig, pos: Vector2):
	var enemy = EnemyScene.instantiate()
	enemy.position = pos
	enemy.setup_from_config(config)
	add_child(enemy)
