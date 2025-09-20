extends Node2D

@onready var spawner: Node2D = $EnemySpawner
@onready var camera: Camera2D = $Camera2D

func _ready():
	var player_scene = load("res://scenes/entities/player.tscn")
	var player: IPlayer = player_scene.instantiate()
	var cfg: CharacterConfig = load("res://characters/Test.tres")
	player.setupFromConfig(cfg)
	add_child(player) 
	player.global_position = Vector2(400, 400)

	PlayerManager.currentPlayer = player 

	camera.position = player.position
	camera.set_as_top_level(true)
	camera.make_current()
	camera.position_smoothing_enabled = true
	camera.position_smoothing_speed = 5.0
	camera.global_position = player.global_position
	camera.get_parent().remove_child(camera)
	player.add_child(camera)

	spawner.SpawnEnemiesAround(player.global_position)
