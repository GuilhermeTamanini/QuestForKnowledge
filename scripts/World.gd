extends Node2D

@onready var player = $Player
@onready var spawner = $EnemySpawner

func _ready():
	var goblin_cfg = preload("res://enemies/slime.tres")
	
	spawner.spawn_enemy(goblin_cfg, Vector2(300, 200))
