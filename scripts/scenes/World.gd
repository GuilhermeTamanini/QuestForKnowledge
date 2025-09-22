### World.gd
extends Node2D

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
	player.global_position = GlobalManager.playerPosisionBeforeLastBattle

	GlobalManager.currentPlayer = player

	var camera = Camera2D.new()
	player.add_child(camera)
	camera.position = Vector2.ZERO
	camera.make_current()
	camera.position_smoothing_enabled = true
	camera.position_smoothing_speed = 5.0
	camera.zoom = Vector2(0.5, 0.5)
	
	EnemyManager.instantiateEnemies(self)
